class SystemAccessRequestForm {
    constructor(dropDownInDur , dropDownOutDur, requiredDelay) {
        this.dropDownInDur = dropDownInDur;
        this.dropDownOutDur = dropDownOutDur;
        this.requiredDelay = requiredDelay;
  }
}

$(document).ready(function(){
    let b = new SystemAccessRequestForm(500, 400, 300);

});
