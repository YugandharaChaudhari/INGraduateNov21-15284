const readline = require("readline");

const rl = readline.createInterface({

    input: process.stdin,

    output: process.stdout

});



rl.question("Enter occasion =  ", function(occasion) {

  switch(occasion)

  {

    case "New Year" :

                   console.log("Happy New Year");

                    break;

    case "Christmas" :

                    console.log("Merry Chrismas  ");

                     break;    

    case "Birthday" :

                    console.log("Happy Birthday");

                     break;  

                 

    case "Anniversary" :

                  console.log("Happy Anniversary");

                  break;  

       default :

                    console.log("Please Enter Correct Way");                    

  }

  rl.close();

});