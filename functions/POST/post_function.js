const { DynamoDBClient, PutItemCommand } = require("@aws-sdk/client-dynamodb");
const { marshall } = require("@aws-sdk/util-dynamodb");

exports.handler = async (event) => {
  try {
    const tableName = process.env.DB_TABLE_NAME || "amazon_seller_batch_table";
    const client = new DynamoDBClient({ region: "us-west-1" });

    const postBody = event.body;
    const bodyToSave = marshall(postBody);

    const dbCommand = new PutItemCommand({
      TableName: tableName,
      Item: bodyToSave,
    });
    const dbCommandResponse = await client.send(dbCommand);

    if (dbCommandResponse.$metadata.httpStatusCode !== 200) {
      throw new Error("Could not save item into db");
    }

    return {
      statusCode: 201,
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        message: "Successfully saved item into DB",
      }),
      isBase64Encoded: false,
    };

  } catch (err) {
    return {
      statusCode: err?.statusCode === 500 || 400,
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        message: "Could not create (POST) item into DB",
        error: err.toString(),
      }),
      isBase64Encoded: false,
    };
  }
};
