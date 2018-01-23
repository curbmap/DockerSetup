use admin;
db.createUser({user: "testing", 
  pwd: "testing", 
  roles: [{ role: "dbAdminAnyDatabase", db: "admin" },
          {role: "readWriteAnyDatabase", db: "admin"}]
})