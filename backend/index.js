// index.js
import express from "express";
import { initializeApp } from "firebase/app";
import { getDatabase, ref, get } from "firebase/database";
import { getAuth, signInAnonymously } from "firebase/auth";
import fs from "fs/promises";
import path from "path";
import { fileURLToPath } from "url";

// ── ESM __dirname shim ─────────────────────────────────────────────────────────
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// ── Path to your JSON log file ────────────────────────────────────────────────
const DATA_FILE = path.join(__dirname, "data.json");
let logArray = [];

// ── Ensure data.json exists & load its contents ───────────────────────────────
async function initLogFile() {
  try {
    // Create file if it doesn’t exist
    await fs
      .access(DATA_FILE)
      .catch(() => fs.writeFile(DATA_FILE, "[]", "utf8"));
    // Load into memory
    const raw = await fs.readFile(DATA_FILE, "utf8");
    const parsed = JSON.parse(raw);
    logArray = Array.isArray(parsed) ? parsed : [];
  } catch (err) {
    console.error("❌ Failed to initialize log file:", err);
    process.exit(1);
  }
}

// ── Your Firebase web‐SDK config ───────────────────────────────────────────────
const firebaseConfig = {
  apiKey: "AIzaSyDwILhkdXU4iqY3c6ju1QPsRctMGcn0sQs",
  authDomain: "power-module-trace-city.firebaseapp.com",
  databaseURL:
    "https://power-module-trace-city-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "power-module-trace-city",
  storageBucket: "power-module-trace-city.firebasestorage.app",
  messagingSenderId: "369893751494",
  appId: "1:369893751494:web:2adbfd98979833290c35c7",
  measurementId: "G-DGYXC5WB8H",
};

// ── Initialize Firebase & Auth ────────────────────────────────────────────────
initializeApp(firebaseConfig);
const auth = getAuth();
const db = getDatabase();
const dataRef = ref(db, "/"); // ← root of your RTDB

// ── State for detecting key-changes ────────────────────────────────────────────
let previousKey = null;
let deviceActive = false;

// ── Fetch from RTDB, determine deviceActive, return data ───────────────────────
async function refreshStatus() {
  const snap = await get(dataRef);
  const d = snap.val() || {};
  const k = d.key;
  deviceActive = previousKey !== null && k !== previousKey;
  previousKey = k;
  return d;
}

// ── Get a Colombo-time ISO string (+05:30) ────────────────────────────────────
function getColomboTimeIso() {
  const now = new Date();
  const offsetMins = 5.5 * 60;
  const localTs = new Date(now.getTime() + offsetMins * 60 * 1000);
  const pad = (n) => String(n).padStart(2, "0");
  return (
    `${localTs.getUTCFullYear()}-${pad(localTs.getUTCMonth() + 1)}-${pad(
      localTs.getUTCDate()
    )}` +
    `T${pad(localTs.getUTCHours())}:${pad(localTs.getUTCMinutes())}:${pad(
      localTs.getUTCSeconds()
    )}+05:30`
  );
}

// ── Periodic task: every 2s, fetch, log status, and append to data.json ─────
async function periodicLog() {
  try {
    const data = await refreshStatus();
    const record = {
      time: getColomboTimeIso(),
      data,
      deviceStatus: deviceActive,
    };

    console.log(
      `[${new Date().toISOString()}] Device is ${
        deviceActive ? "ACTIVE" : "INACTIVE"
      }`
    );

    // Append to memory, cap to last 1000
    logArray.push(record);
    if (logArray.length > 1000) {
      logArray = logArray.slice(-1000);
    }

    // Persist the entire array
    await fs.writeFile(DATA_FILE, JSON.stringify(logArray, null, 2), "utf8");
    console.log(`📄 data.json now contains ${logArray.length} records`);
  } catch (err) {
    console.error("❌ periodicLog error:", err);
  }
}

// ── Start the server & periodic logging ───────────────────────────────────────
async function start() {
  await initLogFile();

  // Anonymous sign-in (ensure your RTDB rules allow auth != null)
  await signInAnonymously(auth);
  console.log("✅ Signed in anonymously to RTDB");

  // Kick off periodic logging every 2 seconds
  await periodicLog();
  setInterval(periodicLog, 2000);

  // Express API
  const app = express();

  // Latest single record
  app.get("/deviceLivedata", async (_, res) => {
    try {
      const data = await refreshStatus();
      return res.json({
        time: getColomboTimeIso(),
        data,
        deviceStatus: deviceActive,
      });
    } catch (err) {
      console.error("❌ /deviceLivedata error:", err);
      return res.status(500).json({ error: err.message });
    }
  });

  // Return full log array
  app.get("/alldata", (_, res) => {
    res.json(logArray);
  });

  app.listen(3300, () => {
    console.log("🚀 API listening on http://localhost:3300");
    console.log("   • GET /deviceLivedata");
    console.log("   • GET /alldata");
  });
}

start().catch((err) => {
  console.error("💥 Fatal error:", err);
  process.exit(1);
});
