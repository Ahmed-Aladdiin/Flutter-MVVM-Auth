import express from 'express';
import mongoose from 'mongoose';
import authRouter from './routes/auth.route.js';

const port = process.env.PORT || 8000;

const app = express();

mongoose.connect(process.env.DB_URL).then(() => {
  console.log('Connected to Database successfully');
}).catch((e) => {
  console.error(`Error connecting to DB: ${e}`);
});

app.use(express.json());

app.use('/auth', authRouter);

app.listen(port, (error) => {
  if (error) return console.error(error);
  console.log(`Server started listening at port ${port}`);
});