Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6884225E
	for <lists+linux-s390@lfdr.de>; Wed, 12 Jun 2019 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfFLKWw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 12 Jun 2019 06:22:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfFLKWw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:22:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2185F308FC4A;
        Wed, 12 Jun 2019 10:22:52 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-159.ams2.redhat.com [10.36.116.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F60060CCC;
        Wed, 12 Jun 2019 10:22:49 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 0/4] s390/crypto: Use -ENODEV instead of -EOPNOTSUPP
Date:   Wed, 12 Jun 2019 12:22:44 +0200
Message-Id: <20190612102248.18903-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 12 Jun 2019 10:22:52 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

s390x crypto is one of the rare modules that returns -EOPNOTSUPP instead of
-ENODEV in case HW support is not available.

Convert to -ENODEV, so e.g., systemd's systemd-modules-load.service
ignores this error properly.

v1 -> v2:
- Include
-- "s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP"
-- "s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP"
-- "s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP"

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>

David Hildenbrand (4):
  s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
  s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP
  s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP
  s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP

 arch/s390/crypto/ghash_s390.c  | 2 +-
 arch/s390/crypto/prng.c        | 4 ++--
 arch/s390/crypto/sha1_s390.c   | 2 +-
 arch/s390/crypto/sha256_s390.c | 2 +-
 arch/s390/crypto/sha512_s390.c | 2 +-
 drivers/s390/crypto/pkey_api.c | 6 +++---
 6 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.21.0

