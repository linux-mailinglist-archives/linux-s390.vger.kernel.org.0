Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4757821DDAC
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2020 18:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgGMQmB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 13 Jul 2020 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbgGMQmB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 13 Jul 2020 12:42:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D903C061794
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2020 09:42:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id p3so6272796pgh.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2020 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=D2p8l4RwF49IaqlGNhFNX2PDV06ZlxWtnVEnPdUoVvI=;
        b=m5S65qmfAtZ+DE6jugUsn8dEUbqv/Od3SPF9f/W9FSZBQkdNPKjvKWE2boVCT6lXgO
         E8YlghSYcJ9cGJjOWRtHAekPaSoOQ7oqvC+Uqgfjck0RsnfIcSFMxhEXkmXrb9KxmtC/
         T5xnq1otpS6eXZAzJoLSoOXD6HfaAQDi5y5jpNz7AFkLkbNL12AKXTX8zPkVwUnauHrq
         MVlNIg0A6QrPRXvovutsReTUOY5VF7Cph4Z4NAlAiFRB3RjswipwYtUdKyum78dpGRmo
         2yKzdKG7dg3vrHVwTFnBMXedvw8QAiwXISKONtYvVUGkYyQh0OhjpVV9pElnPD2wfomr
         LbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=D2p8l4RwF49IaqlGNhFNX2PDV06ZlxWtnVEnPdUoVvI=;
        b=phu+8v9j03G0r7Ydzkn/Sn2GxmbKhJHz4pGnaGaJqoI0+717K/5RO/Qq36F8j5jtdb
         Vpp5RrD+yY4BbG8ZV7znpUzcZmp46phKuFbJV6ZMSfX7fZyUgQNiFD46sO3fo+82qLTJ
         cLrBHQCov86PUNK5GSNYpoHBS3Rc0nhrLeruyCCwiduXyuP7vnpmnUMrx9hkxZ7o3hiX
         2Jf3PJSlawHF6LEN8zP1zC48tlFn+mDuyL1padEVl6d+cYSNntslGgIi+FwsYCa+QCse
         WoaJsLAqXkW8oMk9SVcMbNSZSG7M5XQiASSgop4UWH9f6qmOgM/EkHb19Gm+x0fW0vqB
         PPqA==
X-Gm-Message-State: AOAM530QfRXhfjSV5wzrx/UOFIl8mTbL39Ax9tqHdTrUm37l/onvsjq6
        psKjFvmOh+v96D4+bpd4vHoCJaiobo6pffP0bZdnSFWX
X-Google-Smtp-Source: ABdhPJxNzaUg1VYYGrzhokFLtflG3YjdoqVeK+4vCAApZU91rqUmtpGucUbX0k0uo97Mx2Lr6oCeAPObb5srhfy+MOw=
X-Received: by 2002:aa7:9303:: with SMTP id 3mr682479pfj.108.1594658520341;
 Mon, 13 Jul 2020 09:42:00 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Jul 2020 09:41:49 -0700
Message-ID: <CAKwvOdn-2E=v_7Uie71pz2jjYCKnk98K1Ly8EkpxzvC6M5pXFA@mail.gmail.com>
Subject: linux plumbers + clang + s390 virtualized testing
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Vasily and Heiko,
We were very excited to see your patches going by for enabling Clang
support for s390.  Since then, we've added s390 builds to our
continuous integration setup.

We've been running into a few issues with doing virtualized boot tests
of our kernels on s390.

I was curious if you'll both be attending Linux plumbers conf?  If we
carve out time for an s390+clang talk, would this be of interest to
you to attend?
-- 
Thanks,
~Nick Desaulniers
