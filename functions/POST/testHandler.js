let handler = require('./post_function');

const invokeJson = {
    body: {
        "asin": "23143"
    }
}

handler.handler(invokeJson, {}, (error, result) => {
    if(error) console.error(JSON.stringify(error, null, 2));
    else console.log(JSON.stringify(result, null, 2));
})