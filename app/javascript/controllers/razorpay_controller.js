import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="razorpay"
export default class extends Controller {
  connect() {
    this.orderId = this.element.getAttribute("razor-order-id");
    this.amount = this.element.getAttribute("razor-amount");
    this.pay();
  }

  // initialize() {
  //   this.element.setAttribute("data-action", "mouseover->razorpay#pay");
  // }

  pay() {
    var options = {
      key: "rzp_test_TvjPuhR2mnx6ej", // Enter the Key ID generated from the Dashboard
      amount: this.amount, // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
      currency: "INR",
      name: "eCommerce",
      description: "Test Transaction",
      image: "https://example.com/your_logo",
      order_id: this.orderId, //This is a sample Order ID. Pass the `id` obtained in the response of Step 1
      handler: function (response) {
        // alert(response.razorpay_payment_id);
        // alert(response.razorpay_order_id);
        // alert(response.razorpay_signature);
        var paymentData = {
          payment_id: response.razorpay_payment_id,
          order_id: response.razorpay_order_id,
          signature: response.razorpay_signature,
        };

        window.location.href = "http://localhost:3000/success";

        fetch("http://localhost:3000/order", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector("meta[name='csrf-token']")
              .content,
          },
          body: JSON.stringify(paymentData),
        })
          .then((response) => response.json())
          .catch((error) => {
            console.error("Error: ", error);
          });
      },
      prefill: {
        name: "Gaurav Kumar",
        email: "gaurav.kumar@example.com",
        contact: "9000090000",
      },
      notes: {
        address: "Razorpay Corporate Office",
      },
      theme: {
        color: "#3399cc",
      },
    };
    var rzp1 = new Razorpay(options);
    rzp1.on("payment.failed", function (response) {
      alert(response.error.code);
      alert(response.error.description);
      alert(response.error.source);
      alert(response.error.step);
      alert(response.error.reason);
      alert(response.error.metadata.order_id);
      alert(response.error.metadata.payment_id);
    });
    document.getElementById("rzp-button1").onclick = function (e) {
      rzp1.open();
      e.preventDefault();
    };
  }
}
