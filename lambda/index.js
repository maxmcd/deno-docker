"use strict";

const { exec } = require("child_process");
exports.http = (request, response) => {
  exec("./deno", (err, stdout, stderr) => {
    if (err) {
      console.log(err);
      return;
    }
    // the *entire* stdout and stderr (buffered)
    console.log(`stdout: ${stdout}`);
    console.log(`stderr: ${stderr}`);
  });
  response.status(200).send("Hello World!");
};

exports.event = (event, callback) => {
  callback();
};
