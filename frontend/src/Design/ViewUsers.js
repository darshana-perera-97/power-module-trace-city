import React, { useState, useEffect } from "react";

export default function ViewUsers() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    fetch("http://localhost:3300/viewUsers")
      .then((r) => r.json())
      .then(setUsers)
      .catch(console.error);
  }, []);

  return (
    <div>
      <h2>All Users ({users.length})</h2>
      <table border="1" cellPadding="5">
        <thead>
          <tr>
            {[
              "userName",
              "accountNumber",
              "device",
              "address",
              "tp",
              "userId",
            ].map((h) => (
              <th key={h}>{h}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {users.map((u, i) => (
            <tr key={i}>
              {Object.values(u).map((v, j) => (
                <td key={j}>{v}</td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
