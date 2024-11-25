import 'package:flutter/material.dart';

class DemonstrationExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '준비운동',
                      style: TextStyle(
                        fontSize: 100,
                        fontFamily: "PaperlogyBold",
                        color: Colors.teal[800],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      '스트레칭',
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontFamily: "PaperlogySemiBold",
                        color: Colors.teal[800],
                      ),
                    ),
                    SizedBox(height: screenHeight*0.01),
                    Text(
                      '목표 갯수 : 5',
                      style: TextStyle(
                        fontFamily: 'PaperlogySemiBold',
                        fontSize: screenWidth * 0.07,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_circle_right,
                        color: Colors.teal[800],
                        size: screenWidth * 0.1,
                      ),
                      onPressed: () {
                        print('운동 시작 버튼 클릭됨');
                      },
                    ),
                    Text(
                      '운동시작',
                      style: TextStyle(
                        fontFamily: 'PaperlogySemiBold',
                        fontSize: screenWidth * 0.055,
                        color: Colors.teal[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
  Widget _buildInfoBox(BuildContext context, String title, String content,
      double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "PaperlogyBold",
            fontSize: screenWidth * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          decoration: BoxDecoration(
            color: Colors.teal[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "PaperlogySemiBold",
              fontSize: screenWidth * 0.058,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}