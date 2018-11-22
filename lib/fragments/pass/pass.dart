import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pass_master/api/pass.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../models/pass.dart';
import '../../models/datetime.dart';
import '../../models/currentuser.dart';
import '../messages.dart';

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
    originalPass = pass;
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
      setState((){
        pass = pass;
      });
    } catch(e) {
      Messages.error("Error approving", context);
    }

  }

  @override
  Widget build(BuildContext context) {
    //Shows loading if pass is null
    if(pass == null){
      // Loading animation
      return new Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: new Column(
          children: <Widget>[new Expanded(
            child: new Container(
              height: double.infinity, // force card to take up full space
              width: double.infinity, 
              padding: EdgeInsets.all(25.0),
              alignment: FractionalOffset.center,
              child: new SizedBox(
                width: 75.0,
                height: 75.0,
                child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                  strokeWidth: 5.0,
                ),
              )
            )
          )]
        )
      );
    }

    // Title Setup
    Row titleRow = new Row(
      children: <Widget>[
        new Container(child: pass.getIcon(), padding: EdgeInsets.all(10.0),),
        new Expanded(
          child: new AutoSizeText(
            pass.getName(),
            textAlign: TextAlign.left,
            maxLines: 1,
            style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
    
    // Descriptors
    List<Widget> descriptors = [];
    TextStyle descriptorStyle = TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0);
    
    descriptors.add(new Row(children: <Widget>[new Expanded(child: 
      new AutoSizeText("Origin Teacher: " + (pass?.originTeacher?.getName() ?? ""), maxLines: 1, style: descriptorStyle)
    )],));

    if(pass.timeLeftOrigin != null) {
      descriptors.add(new Row(children: <Widget>[new Expanded(child:
        new AutoSizeText("Left Origin: " + MyDateTime.getTime(pass.timeLeftOrigin), maxLines: 1, style: descriptorStyle)
      ),],));
     MyDateTime.getTime(pass.timeLeftOrigin);
    }
    if(pass.timeArrivedDestination != null) {
      descriptors.add(new Row(children: <Widget>[new Expanded(child:
        new AutoSizeText("Arrived Destination: " + MyDateTime.getTime(pass.timeLeftOrigin), maxLines: 1, style: descriptorStyle)
      ),],));
    }

    // Initialize approve signin, and signout buttons
    RaisedButton signInButton = new RaisedButton(
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {
        signIn();
      },
      child: new Container(
        width: 500.0,
        child: new Text(
          "Sign in",
          style: new TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      )
    );

    RaisedButton signOutButton = new RaisedButton(
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {
        signOut();
      },
      child: new Container(
        width: 500.0,
        child: new Text(
          "Sign out",
          style: new TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      )
    );

    RaisedButton approveButton = new RaisedButton(
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {
        approve();
      },
      child: new Container(
        width: 500.0,
        child: new Text(
          "Approve",
          style: new TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      )
    );

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
    // If the user is a student, show nothing
    else {
      actionButtons = new Expanded(
        child: new Container(
          alignment: FractionalOffset.bottomCenter,
        ),
      );
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
            actionButtons
          ],
        ),
      ),
    );
  }
}