# === Golo4Kids ===

import console

function effacerEcran = -> console():clear()
function afficherMessageBleu = |row, col, message| -> console():blue():pos(row, col):eraseLine():print(message)
function afficherMessageVert = |row, col, message| -> console():green():pos(row, col):eraseLine():print(message)
function afficherMessageRouge = |row, col, message| -> console():red():pos(row, col):eraseLine():print(message)


augment gololang.Animal {

  function rouge = |this| {
    console():red()
    return this
  }

  function vert = |this| {
    console():green()
    return this
  }

  function bleu = |this| {
    console():blue()
    return this
  }

  function jaune = |this| {
    console():yellow()
    return this
  }

  function afficher = |this| {
    console():pos(this:y(), this:x()):print(this:avatar())
    return this
  }

  function effacer = |this| {
    console():pos(this:y(), this:x()):print("\u2022")
    return this
  }

  function droite = |this| {
    this:effacer():x(this:x() + 1):afficher()
    return this
  }

  function gauche = |this| {
    this:effacer():x(this:x() - 1):afficher()
    return this
  }

  function bas = |this| {
    this:effacer():y(this:y() + 1):afficher()
    return this
  }

  function haut = |this| {
    this:effacer():y(this:y() - 1):afficher()
    return this
  }

}
