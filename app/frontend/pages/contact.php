<section id="contact" class="contact">
    <div class="container">

        <div class="section-title text-center mt-4" style="height: 10rem;" data-aos="fade-up">
            <h1>Thông tin liên hệ</h1>
            <p>Liên hệ với chúng tôi bất cứ khi nào!</p>
        </div>

        <div class="row">

            <div class="col-lg-6 left-col text-center" data-aos="fade-right" data-aos-delay="100">
                <div class="info">

                    <div class="email">
                        <i class="icofont-envelope"></i>
                        <h4>Email:</h4>
                        <a href="mailto:phqlong2810@gmail.com">info@bksoft.com.vn</a>
                    </div>

                    <div class="phone">
                        <i class="icofont-phone"></i>
                        <h4>Call:</h4>
                        <a href="tel:+84 082 999 8922">+84 082 999 8922</a>
                    </div>

                    <div class="address">
                        <h4>
                            <ion-icon name="location-outline"></ion-icon>
                            Địa chỉ:
                        </h4>
                        <p>Tòa H6, Đại học Bách khoa HCM, Dĩ An, Bình Dương</p>
                        <iframe src="https://www.google.com/maps/embed/v1/place?q=place_id:ChIJf5mMVqXYdDERDG4WevEFrN4&key=AIzaSyCLy-jNKbq2TcDSCRoYbqE8zM_ehxFUAI4" frameborder="0" allowfullscreen>
                        </iframe>
                    </div>


                </div>

            </div>

            <div class="col-lg-6 mt-5 mt-lg-0" data-aos="fade-left" data-aos-delay="200">

                <form method="post" role="form" class="contact-form">
                    <div class="form-row">
                        <div class="col-md-6 form-group">
                            <label for="name">Họ và tên</label>
                            <input type="text" name="name" class="form-control" id="name" placeholder="Tên của bạn" data-rule="minlen:4" data-msg="Please enter at least 4 chars" />
                            <div class="validate"></div>
                        </div>
                        <div class="col-md-6 form-group">
                            <label for="email">Địa chỉ email</label>
                            <input type="email" class="form-control" name="email" id="email" placeholder="Địa chỉ email" data-rule="email" data-msg="Please enter a valid email" />
                            <div class="validate"></div>
                        </div>
                    </div>
                    <div className="text-muted">
                        <p> Chúng tôi sẽ không bao giờ chia sẻ thông tin cá nhân của bạn!</p>
                    </div>

                    <div class="form-group">
                        <input type="text" class="form-control" name="subject" id="subject" placeholder="Tiêu đề" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" />
                        <div class="validate"></div>
                    </div>
                    <div class="form-group">
                        <textarea class="form-control" name="message" rows="8" data-rule="required" data-msg="Cho chúng tôi biết bạn cảm thấy thế nào." placeholder="Góp ý, liện hệ chúng tôi"></textarea>
                        <div class="validate"></div>
                    </div>

                    <!-- <div class="mb-3">
                        <div class="loading">Loading</div>
                        <div class="error-message"></div>
                        <div class="sent-message">Chúng tôi đã nhận được góp ý của bạn. Cảm ơn bạn rất nhiều!</div>
                    </div> -->
                    <div class="text-center"><button type="submit" class="btn btn-success btn-lg " id="contaact-btn" name="contaact-btn">Gửi</button></div>
                </form>

            </div>

        </div>

    </div>
</section>