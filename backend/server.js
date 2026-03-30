const express = require('express');
const cors = require('cors');
const fs = require('fs'); 
const app = express();

app.use(express.json());
app.use(cors());

const USERS_FILE = 'users.json';
const loadUsers = () => {
    try{
        if(fs.existsSync(USERS_FILE)){
            const data = fs.readFileSync(USERS_FILE, 'utf8');
            return JSON.parse(data);
        }
    } catch (error) {
        console.error('Error loading users:', error);
    }
    return [];
};


const saveUsers = (users) => {
    try{
        fs.writeFileSync(USERS_FILE, JSON.stringify(users, null, 2));
    } catch (error) {
        console.error('Error saving users:', error);
    }
}

app.post('/users/register', (req, res) => {
    const { name, email, password ,birthDate} = req.body;
    let users = loadUsers();

   
    if(users.some(user => user.email === email)){
        console.log(`Registration failed: Email ${email} is already registered.`);
        return res.status(400).json({ message: 'This email is already registered' });
    }

    const newUser = {
        id: Date.now().toString(),
        name,
        email,
        password,
        birthDate,
        profileImage: '',
        status: 'success'
    };

    users.push(newUser);
    saveUsers(users);
    
    console.log(`Successful registration.`);
    res.status(201).json(newUser);
});


app.post('/users/login', (req, res) => {
    const { email, password } = req.body;
    const users = loadUsers();

    const user = users.find(u => u.email === email && u.password === password);

    if (user) {
        console.log(`Successful login for user: ${email}`);
        res.json(user);
    } else {
        console.log(`Failed login attempt for email: ${email}`);
        res.status(401).json({ message: 'Invalid email or password' });
    }

});

app.listen(3000, '0.0.0.0', () => {
    console.log('Server is running on port 3000');
    console.log('Users will be stored in users.json file');
});