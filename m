Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975E6910BA
	for <lists+linux-s390@lfdr.de>; Sat, 17 Aug 2019 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfHQOYk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 17 Aug 2019 10:24:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfHQOYk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 17 Aug 2019 10:24:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E1C73082A8D;
        Sat, 17 Aug 2019 14:24:40 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2633A4E;
        Sat, 17 Aug 2019 14:24:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] crypto: sha256 - Merge 2 separate C implementations into 1, put into separate library
Date:   Sat, 17 Aug 2019 16:24:28 +0200
Message-Id: <20190817142435.8532-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sat, 17 Aug 2019 14:24:40 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi All,

Here is v2 of my patch series refactoring the current 2 separate SHA256
C implementations into 1 and put it into a separate library.

There are 3 reasons for this:

1) Remove the code duplication of having 2 separate implementations

2) Offer a separate library SHA256 implementation which can be used
without having to call crypto_alloc_shash first. This is especially
useful for use during early boot when crypto_alloc_shash does not
work yet.

3) Having the purgatory code using the same code as the crypto subsys means
that the purgratory code will be tested by the crypto subsys selftests.

This has been tested on x86, including checking that kecec still works.

This has NOT been tested on s390, if someone with access to s390 can
test that things still build with this series applied and that
kexec still works, that would be great.

Changes in v2:
- Use put_unaligned_be32 to store the hash to allow callers to use an
  unaligned buffer for storing the hash
- Add a comment to include/crypto/sha256.h explaining that these functions
  now may be used outside of the purgatory too (and that using the crypto
  API instead is preferred)
- Add sha224 support to the lib/crypto/sha256 library code
- Make crypto/sha256_generic.c not only use sha256_transform from
  lib/crypto/sha256.c but also switch it to using sha256_init, sha256_update
  and sha256_final from there so that the crypto subsys selftests fully test
  the lib/crypto/sha256.c implementation

Regards,

Hans

