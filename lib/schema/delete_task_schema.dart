// #mutation works like a function to accept values for out graphql client
//The syntax is just based needed for graphql to Intergrate properly
//Add 3 pair of quotation mark (6 in total); Add \ before ur parameters
// "deleteTaskJson" - this is actually going to be accessed directly by the class without creating an instance

class DeleteTaskSchema {
  static String deleteTaskJson = """
    mutation(\$todoId : Int!){
      deleteTodo(todoId : \$todoId){
        id
        task
        status
      }
    }  

  """;
}
