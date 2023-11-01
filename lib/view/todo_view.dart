import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter_mvvm/main.dart';
import 'package:weather_app_flutter_mvvm/viewmodel/todo_viewmodel.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  void initState() {
    super.initState();
    final todoViewModel = Provider.of<TodoViewModel>(
        GlobalKeyHelper.navigatorKey.currentState!.context,
        listen: false);
    todoViewModel.loading = true;
    todoViewModel.loadLists();
  }

  @override
  void dispose() {
    final todoViewModel = Provider.of<TodoViewModel>(
        GlobalKeyHelper.navigatorKey.currentState!.context,
        listen: false);
    todoViewModel.cleanup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoViewModel = Provider.of<TodoViewModel>(
        GlobalKeyHelper.navigatorKey.currentState!.context);
    todoViewModel.loadLists();
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Todo",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple),
      body: todoViewModel.loading
          ? Center(child: CircularProgressIndicator())
          : Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 330,
                          child: TextFormField(
                            decoration:
                                InputDecoration(hintText: "New todo list name"),
                            onChanged: (value) =>
                                todoViewModel.newListName = value,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        IconButton(
                            onPressed: () => todoViewModel.newListCommand(),
                            icon: Icon(Icons.add))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8.0),
                        itemCount:
                            todoViewModel.listsResponse.content?.length ?? 0,
                        separatorBuilder: (context, i) => Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          var option = todoViewModel.listsResponse.content
                              ?.elementAt(index);
                          return ExpansionTile(
                            title: Text(option?.name ?? ""),
                            children: [
                              ListTile(
                                title: Text("Delete this list ^"),
                                trailing: IconButton(
                                    onPressed: () async {
                                      await todoViewModel.deleteListCommand(
                                          option?.uuid ?? "");
                                      todoViewModel.loadLists();
                                    },
                                    icon: Icon(Icons.delete)),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 300,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "New todo item"),
                                      onChanged: (value) =>
                                          todoViewModel.newItemNames[
                                              option?.uuid ?? ""] = value,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  IconButton(
                                      onPressed: () => todoViewModel
                                          .newItemCommand(option?.uuid),
                                      icon: Icon(Icons.add))
                                ],
                              ),
                              Divider(),
                              ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8.0),
                                itemCount: option?.items?.length ?? 0,
                                separatorBuilder: (context, i) => Divider(),
                                itemBuilder: (BuildContext context, int index) {
                                  var item = option?.items?.elementAt(index);
                                  return ListTile(
                                    title: Text(
                                      item?.name ?? "",
                                      style: TextStyle(
                                          decoration: item?.status ?? false
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none),
                                    ),
                                    onTap: () async {
                                      await todoViewModel.setItemDoneCommand(
                                          item?.uuid ?? "",
                                          !(item?.status ?? false));
                                    },
                                    trailing: IconButton(
                                        onPressed: () async {
                                          await todoViewModel.deleteItemCommand(
                                              item?.uuid ?? "");
                                        },
                                        icon: Icon(Icons.delete)),
                                  );
                                },
                              ),
                            ],
                            // trailing: IconButton(
                            //     onPressed: () async {
                            //       await todoViewModel
                            //           .deleteListCommand(option?.uuid?? "" );
                            //       todoViewModel.loadLists();
                            //     },
                            //     icon: Icon(Icons.delete))
                            // subtitle: Text(
                            //   "${option?.description ?? ''}",
                            //   softWrap: true,
                            // )
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
