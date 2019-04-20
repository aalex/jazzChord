/**
  * JazzChord Plugin for MuseScore
  * Enter a chord and it creates its notes.
  * @author Alexandre Quessy
  */
import QtQuick 2.0
import MuseScore 3.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtQuick.Window 2.2

MuseScore {
  /**
   * The root item for our MuseScore plugin.
   */

  /**
   * Show some info in the console.
   */
  function showInfo() {
    console.log("MuseScore version: " + mscoreVersion);
  }

  function generateWindowSize() {
    var ratio = 1 / 2.0;
    var ret = [
      Screen.desktopAvailableHeight * ratio,
      Screen.desktopAvailableWidth * ratio
      ];
    return ret;
  }

  function useDesiredSize() {
    var size = generateWindowSize();
    console.log("Desired size: " + size[0] + " x " + size[1]);
    root.width = size[0];
    root.height = size[1];
  }

  function genChordNotes(fundamental, chordType) {
      // TODO: parse fundamental
      // TODO: parse chordType
      // TODO: gen list of notes
      return [60, 64, 67, 69]; // C6 test chord
  }

  function addNotesToScore(chordNotes) {
    console.log("addNotesToScore");
    var score = curScore;
    var cursor = score.newCursor();

    cursor.setDuration(1, 4); // TODO: make it configurable
    // cursor.track = 0;
    // cursor.rewind(0);

    console.log("new Chord");
    // var chord = new Chord(score);
    var chord = new Chord();

    for (var i = 0; i < chordNotes.length; i++) {
      var pitch = chordNotes[i];
      console.log("cursor.addNote(" + pitch + ")");
      // cursor.addNote(pitch);
      chord.addNote(pitch);
    }
    cursor.add(chord);
  }

  function parseChordApplyAndExit() {
    var chordText = "";
    var fundamentalIndex = fundamentalComboBox.currentIndex;
    var fundamental = fundamentalComboBox.textAt(fundamentalIndex);
    console.log("Fundamental: " + fundamental);

    var chordTypeIndex = chordTypeComboBox.currentIndex;
    var chordType = chordTypeComboBox.textAt(chordTypeIndex);
    console.log("Chord type: " + chordType);

    console.log("Chord : " + fundamental + chordType);

    console.log("TODO : " + "create notes");

    console.log("genChordNotes");
    var chordNotes = genChordNotes(fundamental, chordType);

    console.log("addNotesToScore");
    addNotesToScore(chordNotes);

    console.log("Calling Qt.quit()...");
    Qt.quit()
  }

  id: root
  menuPath: "Plugins.jazzChord"
  description: "Enter a chord and it creates its notes."
  version: "0.1.0"
  requiresScore: true
  pluginType: "dialog"
  width: 720
  height: 360
  // width: Screen.desktopAvailableWidth * 0.5
  // height: Screen.desktopAvailableHeight * 0.5
  
  onRun: {
    console.log("Hello from aalex");
    showInfo();
    // useDesiredSize();
  }

  Rectangle {
    color: "#999999"
    anchors.fill: parent
  }

  
  GridLayout {
    anchors.fill: parent

    columns: 2

    // TextField {
    //   id: chordTextField
    //   placeholderText: "Chord - eg. Fm7b5"
    // }

    Label {
      text: qsTr("Fundamental")
    }

    ComboBox {
      id: fundamentalComboBox
      model: [
        "Cb",
        "C", // default
        "C#",
        "Db",
        "D",
        "D#",
        "Eb",
        "E",
        "E#",
        "Fb",
        "F",
        "F#",
        "Gb",
        "G",
        "G#",
        "Ab",
        "A",
        "A#",
        "Bb",
        "B",
        "B#"
      ]
      currentIndex: 1
    }

    Label {
      text: qsTr("Chord type")
    }

    ComboBox {
      id: chordTypeComboBox
      model: [
        "", // default
        "6",
        "M7",
        "m",
        "m7",
        "m9",
        "m11",
        "7",
        "9",
        "b9",
        "#9",
        "#11",
        "#11b13",
        "b9b13",
        "b13",
        "m7b5",
        "dim7",
        "7#5",
        "7b5"
      ]
      currentIndex: 0
    }

    Label {
      text: qsTr("Apply")
    }
        
    Button {
      id: okButton
      text: "Ok"

      onClicked: {
        parseChordApplyAndExit();
      }
    }
  }
}
