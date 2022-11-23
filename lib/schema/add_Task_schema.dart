// #mutation works like a function to accept values for out graphql client
//The syntax is just based needed for graphql to Intergrate properly
//Add 3 pair of quotation mark (6 in total); Add \ before ur parameters
// "addTaskJson" - this is actually going to be accessed directly by the class without creating an instance
//The inputs to the mutation funtion is used in the AddTask Provider

class AddTaskSchema {
  static String addTaskJson = """
  
  mutation(\$task : String!, \$status : String!) {
  createTodo(input : {task : \$task, status : \$status}){
    id
    status
    timeAdded
  }
}
  """;
}
