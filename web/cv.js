var click = 0;
function design(){
    var sheet = document.getElementById('stylesheet');
    click += 1;
    if(click % 2 == 1){
        sheet.setAttribute('href', 'professional.css');
    }
    else {
        sheet.setAttribute('href', 'creative.css');
    }
}

function answers(answer_num){
    var button_name = "button_"+answer_num
    var answers = document.getElementById(answer_num);
    var buttons = document.getElementById(button_name);


    if(answers.style.visibility == 'visible'){
        buttons.innerHTML = 'show answer';
        answers.style.visibility = 'hidden';
    }
    else{
        buttons.innerHTML = 'hide answer';
        answers.style.visibility = 'visible';
    }
}

function onphoto(ph_id){
    var current = document.getElementById('myphoto');
    var selected = document.getElementById(ph_id);
    var tmp;
    tmp = current.src;
    current.src = selected.src;
    selected.src = tmp;

}

function changeColor(){
    var curtime = document.getElementById('clock');
    curtime.style.backgroundColor = "rgba("+(parseInt(Math.random()*255)).toString()+", "+(parseInt(Math.random()*255)).toString()+", "+(parseInt(Math.random()*255)).toString()+", "+(parseFloat(Math.random())).toString()+")"
}