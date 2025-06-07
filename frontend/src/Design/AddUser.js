import React, { useState } from "react";

export default function AddUser() {
  const [form, setForm] = useState({
    userName: "",
    accountNumber: "",
    device: "",
    address: "",
    tp: "",
    userId: "",
  });
  const [msg, setMsg] = useState("");

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setMsg("");
    try {
      const res = await fetch("http://localhost:3300/addUser", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(form),
      });
      const json = await res.json();
      if (json.success) {
        setMsg("User added!");
        setForm({
          userName: "",
          accountNumber: "",
          device: "",
          address: "",
          tp: "",
          userId: "",
        });
      } else {
        setMsg(json.error || "Failed");
      }
    } catch (e) {
      console.error(e);
      setMsg("Error adding user");
    }
  };

  return (
    <div>
      <h2>Add User</h2>
      <form onSubmit={handleSubmit}>
        {Object.keys(form).map((key) => (
          <div key={key} style={{ margin: "8px 0" }}>
            <label style={{ width: 120, display: "inline-block" }}>
              {key}:
            </label>
            <input
              name={key}
              value={form[key]}
              onChange={handleChange}
              required
            />
          </div>
        ))}
        <button type="submit">Add</button>
      </form>
      {msg && <p>{msg}</p>}
    </div>
  );
}
