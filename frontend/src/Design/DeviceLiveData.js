import React, { useState, useEffect } from "react";

export default function DeviceLiveData() {
  const [record, setRecord] = useState(null);
  const fetchLive = async () => {
    try {
      const res = await fetch("http://localhost:3300/deviceLivedata");
      const json = await res.json();
      setRecord(json);
    } catch (e) {
      console.error(e);
    }
  };

  useEffect(() => {
    fetchLive();
    const iv = setInterval(fetchLive, 2000);
    return () => clearInterval(iv);
  }, []);

  if (!record) return <p>Loading…</p>;
  return (
    <div>
      <h2>Live Device Data</h2>
      <pre>{JSON.stringify(record, null, 2)}</pre>
    </div>
  );
}
