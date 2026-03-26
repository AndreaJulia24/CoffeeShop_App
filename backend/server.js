const express = require('express');
const app = express();

app.use(express.json());

const adminUser = { email: "andreaczellecz1234@gmail.com", password: "24052004" };

app.post('/users/login', (req, res) => {
    const { email, password } = req.body;

    if (email === adminUser.email && password === adminUser.password) {
        res.json({ id: "1", name: "Andrea Czellecz", status: "success" });
    } else {
        res.status(401).json({ message: "Error!" });
    }
});

app.listen(3000, () => console.log("Szerver fut: http://localhost:3000"));