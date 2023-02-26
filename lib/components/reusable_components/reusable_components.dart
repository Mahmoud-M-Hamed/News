import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../news_app/news_statemanagement/news_cubit.dart';
import '../../news_app/webview_news_activity/webview_activity.dart';

Widget defaultTextField({
  TextEditingController? textEditingController,
  FormFieldValidator<String>? validator,
  ValueChanged<String>? onSubmitted,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  TextInputType? keyboardType = TextInputType.emailAddress,
  bool obscureText = false,
  String? labelText,
  String? hintText,
  IconData? prefixIcon,
  IconData? suffixIcon,
  List<TextInputFormatter>? inputFormatters,
  double contentPaddingHorizontal = 20,
  double contentPaddingVertical = 20,
  double topLeft = 20,
  double topRight = 20,
  double bottomLeft = 20,
  double bottomRight = 20,
}) =>
    TextFormField(
      keyboardAppearance: Brightness.dark,
      inputFormatters: inputFormatters,
      controller: textEditingController,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: contentPaddingHorizontal,
            vertical: contentPaddingVertical),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: Icon(suffixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
          ),
        ),
      ),
    );

// ------------------------------<NEWS APP>-------------------------

Widget newsAppActivitiesDesign(context, {required List? newsCubitList}) {
  String dateTimeHandler(
      {required String dateFormatPattern, required String dateTime}) {
    final inputString = dateTime;
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    final outputFormat = DateFormat('yyyy-MM-dd HH:mm');
    final dateTimes = inputFormat.parse(inputString);
    final outputString = outputFormat.format(dateTimes);
    return outputString;
  }

  // 'yyyy-MM-dd HH:mm:ss'
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: newsCubitList!.length,
      separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
          height: 1,
          thickness: 1,
          endIndent: 25,
          indent: 25),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  WebViewActivity(newsCubitList[index]['url'])));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (newsCubitList[index]['urlToImage'] == null)
                ? Container(
                    height: 100,
                    width: 100,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  )
                : Container(
                    height: 100,
                    width: 100,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(
                          "${newsCubitList[index]['urlToImage']}",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${newsCubitList[index]['title']}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: NewsCubit.get(context).textColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    dateTimeHandler(
                        dateFormatPattern: 'yyyy-MM-dd HH:mm',
                        dateTime: newsCubitList[index]['publishedAt']),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: NewsCubit.get(context).textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
