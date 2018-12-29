import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../api/pass.dart';

import '../utilities/messages.dart';

import '../models/pass.dart';
import '../models/currentuser.dart';

import '../components/ui/action-button.dart';
import '../components/ui/loader.dart';
import 'qr.dart';


class Pass extends StatefulWidget {
  PassState state;
  PassModel pass;
  CurrentUserModel user;
  String type;
  int pk;

  Pass(this.user, this.pass);

  @override
  PassState createState() => new PassState(this, user, pass);

}

class PassState extends State<Pass> {
  PassModel pass;
  PassModel originalPass;
  CurrentUserModel user;

  PassState(Pass parent, CurrentUserModel user, PassModel pass) {
    parent.state = this;
    this.user = user;
    this.originalPass = pass;
  }

  @override
  void initState() {
    if (originalPass != null) {
      getPass();
    }
  }

  Future<void> getPass() async {
    if(originalPass == null && pass != null) {
      originalPass = pass;
    }
    pass = await PassAPI().getData(user?.token, originalPass?.pk, originalPass?.type, null);
    setState(() {
      pass = pass;
    });
  }

  Future<void> signIn() async {
    Messages.message("Signing In", context);
    try{
      await PassAPI().getData(user.token, originalPass.pk, originalPass.type, "signin");
      pass = await PassAPI().getData(user.token, originalPass.pk, originalPass.type, null);
      setState((){
        pass = pass;
      });
    } catch(e) {
      Messages.error("Error signing in", context);
    }
  }

  Future<void> signOut() async {
    Messages.message("Signing Out", context);
    try{
      await PassAPI().getData(user.token, originalPass.pk, originalPass.type, "signout");
      pass = await PassAPI().getData(user.token, originalPass.pk, originalPass.type, null);
      setState((){
        pass = pass;
      });
    } catch(e) {
      Messages.error("Error signing out", context);
    }
  }

  Future<void> approve() async {
    Messages.message("Approving", context);
    try {
      await PassAPI().getData(user.token, originalPass.pk, originalPass.type, "approve");
      pass = await PassAPI().getData(user.token, originalPass.pk, originalPass.type, null);
      if (mounted) {
        setState((){
          pass = pass;
        });
      }
    } catch(e) {
      Messages.error("Error approving", context);
    }
  }

  void qrcode() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new QR(pass)));
  }

  @override
  Widget build(BuildContext context) {
    //Shows loading if pass is null
    if(pass == null){
      // Loading animation
      return new Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: new Center(
            child: new Loader(true),
        ),
      );
    }

    // Title Setup
    Row titleRow = new Row(
      children: <Widget>[
        new Container(child: pass.getIcon(), padding: EdgeInsets.all(10.0),),
        new Expanded(
          child: new AutoSizeText(
            pass.getName(user) ?? "Type Error",
            textAlign: TextAlign.left,
            maxLines: 1,
            style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold, color: pass.getName(user) == null ? Colors.red : Colors.black),
          ),
        )
      ],
    );
    
    // Descriptors
    List<Widget> descriptors = [];
    TextStyle descriptorStyle = TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0);
    
    descriptors.add(new Row(children: <Widget>[new Expanded(child: 
      new AutoSizeText("Origin: " + (pass?.originTeacher?.getName() ?? ""), maxLines: 1, style: descriptorStyle)
    )],));

    if (user.type == '2') {
      descriptors.add(new Row(children: <Widget>[new Expanded(child: 
        new AutoSizeText("Destination: " + (pass?.getDestination() ?? ""), maxLines: 1, style: descriptorStyle)
      )],));
    }

//    Replaced with disabled action buttons at bottom

//    for (String time in pass.getTimes()) {
//      descriptors.add(new Row(children: <Widget>[new Expanded(child:
//        new AutoSizeText(time, maxLines: 1, style: descriptorStyle)
//      ),],));
//    }

    // Initialize approve signin, and signout buttons
    ActionButton approveButton = new ActionButton("Approve", approve);
    ActionButton signInButton = new ActionButton("Sign In", signIn);
    ActionButton signOutButton = new ActionButton("Sign Out", signOut);
    ActionButton qrButton = new ActionButton("QR Code", qrcode);

    Expanded actionButtons;
    // If the user is a teacher, show correct buttons
    if (this.user.type == "2") {
      if (pass.canApprove) {
        actionButtons = new Expanded(
          child: new Container(
            alignment: FractionalOffset.bottomCenter,
            child: approveButton,
          ),
        );
      }
      else if (pass.canSignOut) {
        actionButtons = new Expanded(
          child: new Container(
            alignment: FractionalOffset.bottomCenter,
            child: signOutButton,
          ),
        );
      }
      else if (pass.canSignIn) {
        actionButtons = new Expanded(
          child: new Container(
            alignment: FractionalOffset.bottomCenter,
            child: signInButton,
          ),
        );
      }
      else {
        actionButtons = new Expanded(
          child: new Container(
            alignment: FractionalOffset.bottomCenter,
          ),
        );
      }
    }
    else {
      actionButtons = new Expanded(
        child: new Container(
          alignment: FractionalOffset.bottomCenter,
          child: pass.nextAction() != null ? qrButton : new Container(),
        ),
      );
    }
    List<Widget> historyChildren = [];
    Column history = new Column(
        children: historyChildren,
    );
    for (String time in pass.getTimes()) {
      historyChildren.add(new Row(children: <Widget>[new Expanded(child: new ActionButton(
      time, null, true
      )),],));
    }

    return new Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: new Container(
        height: double.infinity, // force card to take up full space
        width: double.infinity, // force card to take up full space
        padding: EdgeInsets.all(25.0),
        alignment: Alignment.topLeft,
        child: pass == null ? new Container() : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: titleRow,
            ),
            new Container(
              alignment: Alignment.bottomLeft,
              child: new AutoSizeText(
                this.pass.getDateDuration(),
                maxLines: 1,
                style: TextStyle(color: Colors.grey, fontSize: 20.0),
              ),
            ),
            new Container(
              alignment: Alignment.bottomLeft,
              child: new Column(
                children: descriptors,
              ),
            ),
            new Divider(),
            new Container(
              alignment: Alignment.topLeft,
              child: new Text(
                this.pass.description,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            actionButtons,
            history
          ],
        ),
      ),
    );
  }
}