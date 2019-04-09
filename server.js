const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const mysql = require('mysql');

const app = express();
const port = process.env.PORT || 5000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

if (process.env.NODE_ENV === 'production') {
  // Serve any static files
  app.use(express.static(path.join(__dirname, 'client/build')));

  // Handle React routing, return all requests to React app
  app.get('*', function(req, res) {
    res.sendFile(path.join(__dirname, 'client/build', 'index.html'));
  });
}

// MYSQL
const connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : null,
  database : 'vitta'
});

connection.connect(err => err? console.error(err):null);

app.get('/api/data', (req, res) => {
  const data = {};

  let query = 'SELECT * FROM companies';
  connection.query(query, (err,rows,fields) => {
    if (err) throw err;

    data['companies'] = rows;
  });
  
  query = 'SELECT * FROM products';
  connection.query(query, (err,rows,fields) => {
    if (err) throw err;
    
    data['products'] = rows;
  });

  query = 'SELECT * FROM stocks';
  connection.query(query, (err,rows,fields) => {
    if (err) throw err;
    
    data['stocks'] = rows;
  });

  query = 'SELECT * FROM customers';
  connection.query(query, (err,rows,fields) => {
    if (err) throw err;
    
    data['customers'] = rows;
  });

  query = 'SELECT * FROM suppliers';
  connection.query(query, (err,rows,fields) => {
    if (err) throw err;
    
    data['suppliers'] = rows;
  });

  query = 'SELECT * FROM orders';
  connection.query(query, (err,rows,fields) => {
    if (err) throw err;
    
    data['orders'] = rows;

    res.send(JSON.stringify(data));
  });
});

const handleFormData = data => {
  let dataClone = JSON.parse(JSON.stringify(data));
  Object.keys(dataClone).forEach(key => {
    if (dataClone[key] === '') {
      dataClone[key] = 'NULL';
    } else if (key === 'company_financial_year_start' || key === 'company_financial_year_end') {
      const datearr = dataClone[key].split('/');
      dataClone[key] = `'${datearr[2]}-${datearr[1]}-${datearr[0]}'`;
    } else {
      dataClone[key] = `'${dataClone[key]}'`;
    }
  });
  return dataClone;
};

app.post('/api/form', (req, res) => {
  const formBody = handleFormData(req.body);

  const query = `INSERT INTO companies (${Object.keys(formBody).join(',')}) VALUES (${Object.values(formBody).join(',')})`;

  connection.query(query, (err,rows,fields) => {
    if (err) throw err;
  });
  res.redirect('/');
  res.end();
});

app.listen(port, () => console.log(`Listening on port ${port}...`));
