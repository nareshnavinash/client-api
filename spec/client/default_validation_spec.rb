RSpec.describe 'Default validation' do

  it "boolean datatype validator", :get do
    get('https://jsonplaceholder.typicode.com/todos/1')

    expect(status).to eq(200)
    validate(
        {
            "key": "completed",
            "value": false,
            "operator": "==",
            "type": 'boolean'
        }
    )
  end

  it "multi key-pair response validator", :post do
    post('/api/users', schema_from_json("./data/request/post.json"))

    expect(status).to eq(201)
    validate(
        {
            "key": "name",
            "value": "prashanth sams",
            "operator": "==",
            "type": 'string'
        },
        {
            "key": "id",
            "operator": "!=",
            "type": 'integer'
        }
    )

    validate({"key": "id", "operator": "eql?", "type": 'string'})
  end

  it "multi key-pair response validator - json tree", :get do
    get('https://my-json-server.typicode.com/typicode/demo/db')

    expect(status).to eq(200)
    validate(
        {
            "key": "profile->name",
            "value": "typicode",
            "operator": "==",
            "type": 'string'
        },
        {
            "key": "posts->1->id",
            "value": 2,
            "operator": "==",
            "type": 'integer'
        }
    )
  end

end