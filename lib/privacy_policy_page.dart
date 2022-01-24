import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.greyPrivacy,
        automaticallyImplyLeading: false,
        title: Text(
          'プライバシーポリシー',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Constants.primary,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            height: 0,
            thickness: 0.5,
            color: Constants.greyDivider,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Constants.white,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: SingleChildScrollView(child: Text(privacy)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final privacy = """プライバシーポリシー
  
  
情報の収集と使用


第三者に個人を特定できる情報を提供することはありません。

より良い体験のために、私たちのサービスを使用している間、特定の個人情報を提供するようにあなたに要求する場合があります。
アプリは、あなたを識別するために使用される情報を収集する可能性のあるサードパーティのサービスを使用します。

アプリで使用されるサードパーティのサービスプロバイダー

- ログデータ

サービスを使用するたびに、アプリでエラーが発生した場合、ログデータと呼ばれる電話でデータと情報を（サードパーティ製品を通じて）収集することをお知らせします。このログデータには、デバイスのインターネットプロトコル（「IP」）アドレス、デバイス名、オペレーティングシステムのバージョン、サービスを利用する際のアプリの構成、サービスの使用日時、その他の統計などの情報が含まれる場合があります。

Qiita Feed Appではアプリの利便性向上を目的にして、個人を特定できないよう匿名化したデータを用いてアクセス解析を行なっています。
例えばアプリのクラッシュ情報を匿名で送信し、バグの修正のために利用しています。
またご利用端末のOSやアプリバージョンの使用率などを解析しアプリの改善に役立てています。
このプライバシーポリシーの変更
プライバシーポリシーを随時更新する場合があります。したがって、変更がある場合はこのページを定期的に確認することをお勧めします。このページに新しいプライバシーポリシーを掲載して、変更をお知らせします。これらの変更は、このページに投稿された直後に有効になります。
お問い合わせ
プライバシーポリシーについてご質問やご提案がありましたら、hoge@gmail.comまでお気軽にお問い合わせください。""";
}
