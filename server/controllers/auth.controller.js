import User from "../models/user.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

const authController = {
  signUp: async (req, res) => {
    try {
      const { email, password } = req.body;

      // check if this email is already taken
      let user = await User.findOne({ email });
      if (user) {
        return res.status(400).json({ details: "Email is already taken." });
      }

      // create a hashed password
      const hashedPassword = await bcrypt.hash(password, 7);

      // create and save the user
      user = new User({ ...req.body, password: hashedPassword });
      await user.save();

      return res
        .status(201)
        .json({ details: "User created successfully. Please, log in." });
    } catch (error) {
      console.error(error);
      return res.status(500).json({
        details:
          "An Error occurred while creating your account. Please, try again.",
      });
    }
  },
  logIn: async (req, res) => {
    try {
      const { email, password } = req.body;

      // check if email exists
      let user = await User.findOne({ email }, "+password");
      if (!user) {
        return res.status(400).json({ details: "Invalid email or password" });
      }

      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ details: "Invalid email or password" });
      }

      const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET);

      // remove password before returning the object to the client
      return res
        .status(200)
        .json({ user: { name: user.name, email: user.email }, token: token });
    } catch (error) {
      console.error(error);
      return res.status(500).json({
        details:
          "An error has occurred while fetching your data. Please, try again later.",
      });
    }
  },
  me: (req, res) => {
    try {
      const user = req.user;
      return res.status(200).json({ name: user.name, email: user.email });
    } catch (error) {
      console.error(error);
      return res.status(500).json({ details: "Internal server error" });
    }
  },
};

export default authController;
