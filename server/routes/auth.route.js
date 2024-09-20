import express from "express";
import authController from "../controllers/auth.controller.js";
import authMiddleware from "../middlewares/auth.middleware.js";

const authRouter = express.Router();

authRouter.post("/sign-up", authController.signUp);
authRouter.post("/log-in", authController.logIn);
authRouter.get("/me", authMiddleware, authController.me);

export default authRouter;
