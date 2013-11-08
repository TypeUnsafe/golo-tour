module golo4kids

function main = |args| {

  effacerEcran()
  
  afficherMessageVert(1, 1, "Golo4Kids")

  let tigrou = Tigre("Tigrou")
  let pandi = Panda("PandiPanda")

  tigrou:x(5):y(5):afficher()

  pandi:x(10):y(5):afficher()

  tigrou
   :jaune():bas():bas():bas()
   :rouge():droite():droite()

  7:fois(->pandi:vert():droite())

  3:fois(->pandi:bleu():haut())

  afficherMessageBleu(20,0,"Hello ...")
}
