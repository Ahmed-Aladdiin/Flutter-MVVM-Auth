import jwt from "jsonwebtoken";
import User from "../models/user.js";

const authMiddleware = async (req, res, next) => {
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return res.status(401).json({ details: "No token provided." });
  }

  if (!authHeader.startsWith("Bearer") || authHeader.split(' ').length !== 2) {
    console.error(authHeader);
    return res.status(401).json({ details: "Invalid token." });
  }

  const token = authHeader.split(' ')[1];

  try {
    const { id } = jwt.verify(token, process.env.JWT_SECRET);

    let user = await User.findById(id);

    if (!user) {
      return res.status(404).json({ details: "User not found!" });
    }

    req.user = user;
    next();
  } catch (error) {
    console.error(authHeader);
    console.error(error);
    return res.status(401).json({ details: "Invalid token." });
  }
};

export default authMiddleware;
