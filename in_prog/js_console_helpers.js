const getNextButton = (selector='.btn-large.nextButton') => {
	try(){
		document.querySelector(selector);
	} catch(err){
		console.log(err);
	} finally {
		console.log("Here, kid, have a button.");
	}
}

const clickNext = (nextSelector) => {
    const nxtBtn = document.querySelector(nextSelector)
}



const watchElementPosition = (element) => {
    const element = document.getElementById('myElement');

    const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
            if (mutation.type === 'attributes' && mutation.attributeName === 'style') {
                const currentLeft = element.style.left;

                console.log('Left position changed to:', currentLeft);

      }
    }
  });
});

    const config = { attributes: true, attributeFilter: ['style'] };

    observer.observe(element, config);
}
