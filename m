Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD40D427F1
	for <lists+linux-s390@lfdr.de>; Wed, 12 Jun 2019 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436827AbfFLNsd (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 12 Jun 2019 09:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436800AbfFLNsd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 09:48:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64D3D309703F;
        Wed, 12 Jun 2019 13:48:28 +0000 (UTC)
Received: from gondolin (ovpn-116-169.ams2.redhat.com [10.36.116.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A82841001B13;
        Wed, 12 Jun 2019 13:48:21 +0000 (UTC)
Date:   Wed, 12 Jun 2019 15:48:18 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] s390/crypto: Use -ENODEV instead of -EOPNOTSUPP
Message-ID: <20190612154818.69a02949.cohuck@redhat.com>
In-Reply-To: <20190612133306.10231-1-david@redhat.com>
References: <20190612133306.10231-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 12 Jun 2019 13:48:33 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 12 Jun 2019 15:33:02 +0200
David Hildenbrand <david@redhat.com> wrote:

> s390x crypto is one of the rare modules that returns -EOPNOTSUPP instead of
> -ENODEV in case HW support is not available.
> 
> Convert to -ENODEV, so e.g., systemd's systemd-modules-load.service
> ignores this error properly.
> 
> v2 -> v3:
> - "s390/pkey: Use -ENODEV instead of -EOPNOTSUPP"
> -- Also convert pkey_clr2protkey() as requested by Harald

Looks reasonable; my r-b still stands.

> - Add r-b's (thanks!)
> 
> v1 -> v2:
> - Include
> -- "s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP"
> -- "s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP"
> -- "s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP"
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> 
> David Hildenbrand (4):
>   s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
>   s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP
>   s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP
>   s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP
> 
>  arch/s390/crypto/ghash_s390.c  | 2 +-
>  arch/s390/crypto/prng.c        | 4 ++--
>  arch/s390/crypto/sha1_s390.c   | 2 +-
>  arch/s390/crypto/sha256_s390.c | 2 +-
>  arch/s390/crypto/sha512_s390.c | 2 +-
>  drivers/s390/crypto/pkey_api.c | 8 ++++----
>  6 files changed, 10 insertions(+), 10 deletions(-)
> 

