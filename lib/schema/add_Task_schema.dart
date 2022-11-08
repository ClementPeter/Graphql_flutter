// #mutation works like a function to accept values for out graphql client
//The syntax is just based needed for graphql to Intergrate properly
//Add 3 pair of quotation mark (6 in total); Add \ before ur parameters
class AddTaskSchema {
  static String addTaskJson = """  
 
mutation(\$task: String!, \$status: String!){
  #this createToDo schema connects our flutter app with graphql
  
  createTodo(input:{task:\$task, status:\$status}){
    id
  }
}   
  """;
}
