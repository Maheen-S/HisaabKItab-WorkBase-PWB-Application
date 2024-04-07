const express = require('express');
const mysql = require('mysql');
const bcrypt = require('bcrypt');
const session = require('express-session');

const app = express();
const port = 3000;
app.set('view engine', 'ejs');
var cors = require('cors')

app.use(cors())



// Set up MySQL connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '1234',
  database: 'Hisab_Kitab'
});

db.connect((err) => {
  if (err) {
    throw err;
  }
  console.log('Connected to database');
});

// Set up Express middleware
app.use(express.urlencoded({ extended: false }));
app.use(express.static('public'));
app.use(session({
  secret: 'secret',
  resave: true,
  saveUninitialized: true
}));

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/login.html');
  });
  
  app.post('/login', (req, res) => {
    const { email, password } = req.body;
  
// Check if the email and password match the database records
db.query('SELECT * FROM users WHERE email = ? AND password = ?', [email, password], (err, results) => {
  if (err) {
    throw err;
  }

  if (results.length === 1) {
    // Set up the session and redirect to the home page
    var type= "Administrator";
    db.query('SELECT *FROM Users WHERE email = ? AND UserType = ?', [email, type], (err, results) => {

      if(results.length === 1){
      req.session.loggedIn = true;
      res.redirect('/homeAdmin');

      }
    type= "Project Manager";
      db.query('SELECT *FROM Users WHERE email = ? AND UserType = ?', [email, type], (err, results) => {
  
        if(results.length === 1){
        req.session.loggedIn = true;
        res.redirect('/homeUser');
  
        }
      })
      
      


    });



  } else {
    res.status(401).render('login', { error: 'Incorrect email or password.' });
  }
  
  
});

  });
  
  app.get('/home', (req, res) => {
    if (req.session.loggedIn) {
      res.sendFile(__dirname + '/home.html');
    } else {
      res.redirect('/');
    }
  });
  
  app.get('/homeAdmin', (req, res) => {
    if (req.session.loggedIn) {
      res.sendFile(__dirname + '/homeAdmin.html');
    } else {
      res.redirect('/');
    }
  });

  app.get('/homeManager', (req, res) => {
    if (req.session.loggedIn) {
      res.sendFile(__dirname + '/homeUser.html');
    } else {
      res.redirect('/');
    }
  });
  

  // Serve the HTML form
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/signup.html');
});

// Handle form submission
app.post('/signup', (req, res) => {
  const userData = req.body;

  // Insert the user data into the database
  connection.query('INSERT INTO Users SET ?', userData, (err, results) => {
    if (err) {
      console.error('Error inserting user:', err);
      res.status(500).send('Error inserting user');
      return;
    }
    res.status(200).send('User signed up successfully');
  });
});

// Start the server
app.listen(3000, () => {
  console.log('Server is running on port 3000');
});




// Serve the registration form
app.get('/new1', (req, res) => {
  res.sendFile(__dirname + '/new1.html');
});

// Handle registration form submission
app.post('/new1', (req, res) => {
  const {
    fullName,
    email,
    password,
    day,
    month,
    year,
    gender,
    phoneNumber,
    terms,
  } = req.body;

  // Validate form data
  if (!fullName || !email || !password || !day || !month || !year || !gender || !phoneNumber || !terms) {
    res.status(400).send('Please fill in all the required fields');
    return;
  }

  // Check if the user already exists
  connection.query('SELECT * FROM Users WHERE email = ?', [email], (err, results) => {
    if (err) {
      console.error('Error checking existing user:', err);
      res.status(500).send('Error checking existing user');
      return;
    }

    if (results.length > 0) {
      res.status(409).send('User already exists');
      return;
    }

    // Insert user data into the Users table
    const user = {
      email: email,
      access_level: 'customer',
      responsibilities: '',
      task: '',
      user_type: 'customer',
    };

    connection.query('INSERT INTO Users SET ?', user, (err, result) => {
      if (err) {
        console.error('Error adding user:', err);
        res.status(500).send('Error adding user');
        return;
      }

      // Insert user phone number into the Phone_Number_User table
      const phoneNumberUser = {
        user_id: result.insertId,
        user_phone_number: phoneNumber,
      };

      connection.query('INSERT INTO Phone_Number_User SET ?', phoneNumberUser, (err) => {
        if (err) {
          console.error('Error adding user phone number:', err);
          res.status(500).send('Error adding user phone number');
          return;
        }

        res.status(200).send('User registered successfully');
      });
    });
  });
});

  // app.get('/addProject', (req, res) => {
  //   if (req.session.loggedIn) {
  //     res.sendFile(__dirname + '/projectsAdd.html');
  //   } else {
  //     res.redirect('/');
  //   }
  // });


  // Route for fetching data from the Projects table
// app.get('/Addproject', (req, res) => {
//   const query = 'SELECT * FROM Projects';
//   db.query(query, (error, results) => {
//     if (error) {
//       res.status(500).send('Error fetching data from the database');
//     } else {
//       res.json(results)
//     }
//   });
// });



// app.get('/Addproject', (req, res) => {
//   if (req.session.loggedIn) {
//     res.sendFile(__dirname + '/projectsAdd.html');
//   } else {
//     res.redirect('/');
//   }
// });

// Route for fetching data from the Projects table
// app.get('/Addproject', (req, res) => {
//   const query = 'SELECT * FROM Projects';
//   db.query(query, (error, results) => {
//     if (error) {
//       console.error('Error fetching data from the database', error);
//       res.status(500).json({ error: 'Error fetching data from the database' });
//     } else {
//       res.json(results);
//     }
//   });
// });


  // app.get('/signup', (req, res) => {
  //   if (1) {
  //     res.sendFile(__dirname + '/signup.html');
  //   } else {
  //     res.redirect('/');
  //   }
  // });
  


  app.post('/signup', (req, res) => {
    res.sendFile(__dirname + '/signup.html');
    const { username, email, usertype, password } = req.body;
  
    const sql = "INSERT INTO Users (UserName, Email, UserType, Password) VALUES (?, ?, ?, ?)";
  
    db.query(sql, [username, email, usertype, password], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).send('Server error');
      } else {
        res.sendFile(__dirname + '/login.html');
      }
    });
  });

  app.get('/signup', function(req, res){
    res.sendFile(__dirname + '/signup.html');
});

app.get('/boards', function(req, res){
  res.sendFile(__dirname + '/boards.html');
});
app.get('/issues', function(req, res){
  res.sendFile(__dirname + '/issues.html');
});
app.get('/projects', function(req, res){
  res.sendFile(__dirname + '/projects.html');
});
app.get('/reports', function(req, res){
  res.sendFile(__dirname + '/reports.html');
});
app.get('/userManagement', function(req, res){
  res.sendFile(__dirname + '/userManagement.html');
});
app.get('/workflows', function(req, res){
  res.sendFile(__dirname + '/workflows.html');
});

  


  app.get('/logout', (req, res) => {
    req.session.destroy((err) => {
      if (err) {
        throw err;
      }
      res.redirect('/');
    });
  });
  
  // Start the server
  app.listen(port, () => {
    console.log(`App listening at http://localhost:${port}`);
  });