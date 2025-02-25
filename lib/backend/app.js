// const express = require("express");
// const mongoose = require("mongoose");
// const cors = require("cors");
// const bodyParser = require("body-parser");
// const bcrypt = require("bcryptjs");

// const app = express();
// const PORT = process.env.PORT || 5000;

// // ✅ Use the correct MongoDB URI
// const MONGO_URI = "mongodb+srv://anirudhchandrasekaran:anan0712@campusconnect.cwg24.mongodb.net/userdb?retryWrites=true&w=majority";

// // Middleware
// app.use(cors());
// app.use(bodyParser.json());

// // 🔹 Connect to MongoDB (Fixed)
// mongoose.connect(MONGO_URI)
//   .then(() => console.log("✅ Connected to MongoDB Atlas"))
//   .catch(err => console.error("❌ Error connecting to MongoDB:", err));

// // ✅ User Schema with Password Hashing
// const userSchema = new mongoose.Schema({
//   name: { type: String, required: true },
//   regNo: { type: String, required: true, unique: true }, // Unique Reg No
//   password: { type: String, required: true }, // Hashed Password
// }, { strict: true });

// const User = mongoose.model("User", userSchema);

// // 🔹 Sign-Up Route
// app.post("/signup", async (req, res) => {
//   const { name, regNo, password } = req.body;

//   if (!name || !regNo || !password) {
//     return res.status(400).json({ message: "❌ All fields are required" });
//   }

//   try {
//     // Check if user exists
//     const existingUser = await User.findOne({ regNo });
//     if (existingUser) {
//       return res.status(400).json({ message: "❌ User already exists" });
//     }

//     // Hash password before saving
//     const salt = await bcrypt.genSalt(10);
//     const hashedPassword = await bcrypt.hash(password, salt);

//     // Save new user
//     const newUser = new User({ name, regNo, password: hashedPassword });
//     await newUser.save();
    
//     res.status(201).json({ message: "✅ User registered successfully!" });
//   } catch (error) {
//     res.status(500).json({ message: "❌ Server error", error });
//   }
// });

// // 🔹 Start Server
// app.listen(PORT, () => {
//   console.log(`🚀 Server running on http://192.168.137.1:${PORT}`);
// });

const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");
const bcrypt = require("bcryptjs");

const app = express();
const PORT = process.env.PORT || 5000;

// ✅ Use the correct MongoDB URI
const MONGO_URI = "mongodb+srv://anirudhchandrasekaran:anan0712@campusconnect.cwg24.mongodb.net/userdb?retryWrites=true&w=majority";

// Middleware
app.use(cors());
app.use(bodyParser.json());

// 🔹 Connect to MongoDB (Fixed)
mongoose.connect(MONGO_URI)
  .then(() => console.log("✅ Connected to MongoDB Atlas"))
  .catch(err => console.error("❌ Error connecting to MongoDB:", err));

// 🔹 Connect to MongoDB
mongoose.connect(MONGO_URI)
  .then(() => console.log("✅ Connected to MongoDB Atlas"))
  .catch(err => console.error("❌ Error connecting to MongoDB:", err));

// ✅ User Schema
const userSchema = new mongoose.Schema({
  name: { type: String, required: true },
  regNo: { type: String, required: true, unique: true },
  password: { type: String, required: true },
});

const User = mongoose.model("User", userSchema);

// ✅ Notes Schema
const noteSchema = new mongoose.Schema({
  regNo: { type: String, required: true }, // User-specific notes
  date: { type: String, required: true },
  time: { type: String, required: true },
  note: { type: String, required: true },
});

const Note = mongoose.model("Note", noteSchema);

// 🔹 API to Add a Note
app.post("/addNote", async (req, res) => {
  const { regNo, date, time, note } = req.body;

  if (!regNo || !date || !time || !note) {
    return res.status(400).json({ message: "❌ All fields are required" });
  }

  try {
    const newNote = new Note({ regNo, date, time, note });
    await newNote.save();
    res.status(201).json({ message: "✅ Note added successfully!" });
  } catch (error) {
    res.status(500).json({ message: "❌ Server error", error });
  }
});

// 🔹 API to Get Notes for a Specific User
app.get("/getNotes/:regNo", async (req, res) => {
  try {
    const { regNo } = req.params;
    const userNotes = await Note.find({ regNo });

    if (!userNotes.length) {
      return res.status(404).json({ message: "❌ No notes found for this user" });
    }

    res.status(200).json({ notes: userNotes });
  } catch (error) {
    res.status(500).json({ message: "❌ Server error", error });
  }
});

// 🔹 Sign-Up Route
app.post("/signup", async (req, res) => {
  const { name, regNo, password } = req.body;

  if (!name || !regNo || !password) {
    return res.status(400).json({ message: "❌ All fields are required" });
  }

  try {
    // Check if user exists
    const existingUser = await User.findOne({ regNo });
    if (existingUser) {
      return res.status(400).json({ message: "❌ User already exists" });
    }

    // Hash password before saving
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Save new user
    const newUser = new User({ name, regNo, password: hashedPassword });
    await newUser.save();
    
    res.status(201).json({ message: "✅ User registered successfully!" });
  } catch (error) {
    res.status(500).json({ message: "❌ Server error", error });
  }
});

app.post("/login", async (req, res) => {
  const { regNo, password } = req.body;

  if (!regNo || !password) {
    return res.status(400).json({ message: "❌ All fields are required" });
  }

  try {
    // Find user by registration number
    const user = await User.findOne({ regNo });

    if (!user) {
      return res.status(404).json({ message: "❌ User not found" });
    }

    // Compare entered password with stored hash
    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ message: "❌ Incorrect password" });
    }

    // ✅ Send user data back
    res.status(200).json({
      message: "✅ Login successful!",
      user: {
        name: user.name,
        regNo: user.regNo,
      },
    });

  } catch (error) {
    res.status(500).json({ message: "❌ Server error", error });
  }
});


// 🔹 Start Server
app.listen(PORT, () => {
  console.log(`🚀 Server running on http://192.168.137.1:${PORT}`);
});
