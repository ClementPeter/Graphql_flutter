// mutation works like a function to accept values for our graphql client
//The syntax is structured this way for graphql to Intergrate properly
//Add 3 pair of quotation mark (6 in total); Add \ before ur parameters
// "getTaskJson" - this is actually going to be accessed directly by the class without creating an instance
//The inputs to the mutation funtion is used in the GetTask Provider

class GetTaskSchema {
  static String getTaskJson = """

    query{
    getTodos(status: "", search: ""){
      id
      task    
      timeAdded
  }
}

""";
}
