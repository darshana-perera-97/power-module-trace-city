// index.js
import { initializeApp } from "firebase/app";
import { getDatabase, ref, get } from "firebase/database";

// Your web app's Firebase configuration
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

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getDatabase(app);

// Point this at the node you want to read
const dataRef = ref(db, "/");

async function fetchAndLog() {
  try {
    const snapshot = await get(dataRef);
    console.log(`[${new Date().toISOString()}]`, snapshot.val());
  } catch (err) {
    console.error("Error fetching data:", err);
  }
}

// Fetch immediately, then every 1 second
fetchAndLog();
setInterval(fetchAndLog, 1_000);
