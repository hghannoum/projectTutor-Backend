const sql = require("mssql/msnodesqlv8");
const bodyParser = require("body-parser");
const express = require("express");
const app = express();
app.use(bodyParser.json());
const cors = require("cors");
app.use(cors());
var config = {
  server: "QSC-PC\\SQLEXPRESS01",
  database: "tutors_project",
  options: {
    trustedConnection: true,
  },
  driver: "msnodesqlv8",
};

app.post("/check-email", async (req, res) => {
  try {
    console.log(req.body);
    const pool = await sql.connect(config);
    const { email } = req.body;
    const result = await pool
      .request()
      .input("email", sql.NVarChar(50), email)
      .output("is_available", sql.Bit)
      .execute("CheckEmailAvailability");
    const { is_available } = result.output;
    res.json({ is_available });
    console.log(is_available);
  } catch (error) {
    console.error(error);
    res.status(500).send("Error checking email availability");
  }
});

app.post("/signup", async (req, res) => {
  try {
    // Extract user data from request body
    const {
      username,
      fullname,
      cat,
      mat,
      country,
      pass,
      img,
      email,
      bio,
      tutor,
      way,
    } = req.body;

    // Create a new database connection pool
    const pool = await sql.connect(config);

    // Execute the stored procedure with user data as parameters
    const result = await pool
      .request()
      .input("username", sql.NVarChar(50), username)
      .input("fullname", sql.NVarChar(100), fullname)
      .input("first_name", sql.NVarChar(20), fullname)
      .input("last_name", sql.NVarChar(20), fullname)
      .input("category", sql.NVarChar(50), cat)
      .input("material", sql.NVarChar(50), mat)
      .input("city", sql.NVarChar(50), country)
      .input("password", sql.NVarChar(50), pass)
      .input("img", sql.NVarChar(200), img)
      .input("email", sql.NVarChar(50), email)
      .input("bio", sql.NVarChar(200), bio)
      .input("is_tutor", sql.Bit, tutor)
      .input("way", sql.NVarChar(50), way)
      .input("subject", sql.NVarChar(50), mat)
      .execute("SignUpUser");
    console.log(result);
    // Send a success response to the client
    res.status(200).json({
      message: "User signed up successfully",
      user_id: result.output.user_id,
    });
  } catch (error) {
    console.error(error);
    // Send an error response to the client
    res.status(500).json({
      message: "An error occurred while signing up user",
      error: error.message,
    });
  }
});

app.post("/login", async (req, res) => {
  try {
    // Extract user data from request body
    const { password, email } = req.body;

    // Create a new database connection pool
    const pool = await sql.connect(config);

    // Execute the stored procedure with user data as parameters
    const result = await pool
      .request()

      .input("password", sql.NVarChar(50), password)
      .input("email", sql.NVarChar(50), email)
      .execute("LoginUser");
    // Send a success response to the client
    res.status(200).send(result.recordsets[0][0]);
  } catch (error) {
    console.error(error);
    // Send an error response to the client
    res.status(500).json({
      message: "An error occurred",
      error: error.message,
    });
  }
});

app.post("/getAll", (req, res) => {
  const { email } = req.body;
  sql.connect(config, (err) => {
    if (err) {
      console.error(err);
      res.status(500).send("Internal server error");
    } else {
      const request = new sql.Request();
      request
        .input("email", sql.NVarChar(50), email)
        .execute("GetAllTutors", (err, result) => {
          if (err) {
            console.error(err);
            res.status(500).send("Internal server error");
          } else {
            res.send(result.recordset);
          }
        });
    }
  });
});

app.post("/insertMeeting", async (req, res) => {
  try {
    // Extract user data from request body
    const { tutor_email, student_emails, start, end, description, title } =
      req.body;

    // Create a new database connection pool
    const pool = await sql.connect(config);

    // Execute the stored procedure with user data as parameters
    const result = await pool
      .request()

      .input("tutor_email", sql.NVarChar(50), tutor_email)
      .input("student_emails", sql.NVarChar(200), student_emails)
      .input("start", sql.DATETIME, start)
      .input("end", sql.DATETIME, end)
      .input("description", sql.NVarChar(200), description)
      .input("title", sql.NVarChar(50), title)
      .execute("insert_meeting");
    // Send a success response to the client
    res.status(200).send("hi");
  } catch (error) {
    console.error(error);
    // Send an error response to the client
    res.status(500).json({
      message: "An error occurred",
      error: error.message,
    });
  }
});

app.post("/getStudents", (req, res) => {
  const { email } = req.body;
  sql.connect(config, (err) => {
    if (err) {
      console.error(err);
      res.status(500).send("Internal server error");
    } else {
      const request = new sql.Request();
      request
        .input("email", sql.NVarChar(50), email)
        .execute("get_students_for_tutor", (err, result) => {
          if (err) {
            console.error(err);
            res.status(500).send("Internal server error");
          } else {
            res.send(result.recordset);
          }
        });
    }
  });
});

app.post("/getSchedule", (req, res) => {
  const { email } = req.body;
  sql.connect(config, (err) => {
    if (err) {
      console.error(err);
      res.status(500).send("Internal server error");
    } else {
      const request = new sql.Request();
      request
        .input("email", sql.NVarChar(50), email)
        .execute("getSchedule", (err, result) => {
          if (err) {
            console.error(err);
            res.status(500).send("Internal server error");
          } else {
            res.send(result.recordset);
          }
        });
    }
  });
});

app.listen(5000, () => {
  console.log("Server running on port 4000");
});

app.post("/sendRequest", async (req, res) => {
  try {
    // Extract user data from request body
    console.log(req.body);
    const { email_from, toId } = req.body;

    // Create a new database connection pool
    const pool = await sql.connect(config);

    // Execute the stored procedure with user data as parameters
    const result = await pool
      .request()

      .input("fromEmail", sql.NVarChar(50), email_from)
      .input("toId", sql.NVarChar(50), toId)
      .execute("SendRequest");
  } catch (error) {
    console.error(error);
    // Send an error response to the client
    res.status(500).json({
      message: "An error occurred",
      error: error.message,
    });
  }
});

app.post("/removecon", async (req, res) => {
  try {
    // Extract user data from request body
    console.log(req.body);
    const { id_request } = req.body;

    // Create a new database connection pool
    const pool = await sql.connect(config);

    // Execute the stored procedure with user data as parameters
    const result = await pool
      .request()

      .input("id_request", sql.NVarChar(50), id_request)
      .execute("removeConnection");
  } catch (error) {
    console.error(error);
    // Send an error response to the client
    res.status(500).json({
      message: "An error occurred",
      error: error.message,
    });
  }
});
app.post("/acceptcon", async (req, res) => {
  try {
    // Extract user data from request body
    console.log(req.body);
    const { id_request } = req.body;

    // Create a new database connection pool
    const pool = await sql.connect(config);

    // Execute the stored procedure with user data as parameters
    const result = await pool
      .request()

      .input("id_request", sql.NVarChar(50), id_request)
      .execute("acceptConnection");
  } catch (error) {
    console.error(error);
    // Send an error response to the client
    res.status(500).json({
      message: "An error occurred ",
      error: error.message,
    });
  }
});

app.post("/deleteRequest", async (req, res) => {
  try {
    // Extract user data from request body
    console.log(req.body);
    const { email_from, toId } = req.body;

    // Create a new database connection pool
    const pool = await sql.connect(config);

    // Execute the stored procedure with user data as parameters
    const result = await pool
      .request()

      .input("fromEmail", sql.NVarChar(50), email_from)
      .input("toId", sql.NVarChar(50), toId)
      .execute("deleteRequest");
  } catch (error) {
    console.error(error);
    // Send an error response to the client
    res.status(500).json({
      message: "An error occurred ",
      error: error.message,
    });
  }
});

app.post("/viewRequests", async (req, res) => {
  try {
    console.log("hi");
    // Extract user data from request body
    console.log(req.body);
    const { email } = req.body;

    // Create a new database connection pool
    const pool = await sql.connect(config);

    // Execute the stored procedure with user data as parameters
    const result = await pool
      .request()

      .input("email", sql.NVarChar(50), email)
      .execute("view_request");
    res.send(result.recordset);
  } catch (error) {
    console.error(error);
    // Send an error response to the client
    res.status(500).json({
      message: "An error occurred",
      error: error.message,
    });
  }
});

// route to update user information
app.post("/updateUser", async (req, res) => {
  try {
    const pool = await sql.connect(config);
    const request = new sql.Request(pool);
    const { username, city, category, bio, img, email } = req.body;

    // check if city exists in City table
    const checkCity = await request.query(
      `SELECT id_city FROM City WHERE name = '${city}'`
    );

    let cityId;

    if (checkCity.recordset.length) {
      // if city exists, use its id
      cityId = checkCity.recordset[0].id_city;
    } else {
      // if city doesn't exist, add it to City table and get its new id
      const addCity = await request.query(
        `INSERT INTO City (name) VALUES ('${city}') SELECT SCOPE_IDENTITY() AS id_city`
      );
      cityId = addCity.recordset[0].id_city;
    }

    // update user information in User_tutorsLeb table
    const updateUser = await request.query(
      `EXEC  UpdateUserTutorLeb @email = '${email}', @username = '${username}', @city = ${cityId}, @category = '${category}', @bio = '${bio}', @img = '${img}'`
    );

    // return success response
    res.status(200).send({ message: "User information updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).send({ message: "Error updating user information" });
  }
});
