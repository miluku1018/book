import braintree from 'braintree-web-drop-in';
//import xxxx(名稱可以隨意取名),line 11就是取用上面的名稱

document.addEventListener('turbolinks:load', () => {
  let container = document.querySelector('#dropin-container');

  if (container) {
    let button = document.querySelector('#submit-button');
    let token = document.querySelector('#token').value;

    braintree.create({
      authorization: token,
      container: '#dropin-container'
    }, function (createErr, instance) {
      button.addEventListener('click', function () {
        instance.requestPaymentMethod(function (err, payload) {
          let hidden_field = document.querySelector('#nonce');
          let form = document.querySelector('#payment-form');
          hidden_field.value = payload.nonce;
          form.submit();
        });
      });
    });
  }
});

