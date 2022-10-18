class HomeController {
  String NumberTypeinTask(int number) {
    if (number == 0) return "";
    return number == 1 ? " • 1 Tarefa"  : " • $number Tarefas";
  }
}
