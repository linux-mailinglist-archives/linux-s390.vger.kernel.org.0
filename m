Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B0E42297
	for <lists+linux-s390@lfdr.de>; Wed, 12 Jun 2019 12:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406415AbfFLKfV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 12 Jun 2019 06:35:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406375AbfFLKfV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:35:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC5473082A9B;
        Wed, 12 Jun 2019 10:35:20 +0000 (UTC)
Received: from gondolin (ovpn-116-169.ams2.redhat.com [10.36.116.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F1B339B9;
        Wed, 12 Jun 2019 10:35:15 +0000 (UTC)
Date:   Wed, 12 Jun 2019 12:35:13 +0200
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
Subject: Re: [PATCH v2 3/4] s390/crypto: prng: Use -ENODEV instead of
 -EOPNOTSUPP
Message-ID: <20190612123513.7a9fb438.cohuck@redhat.com>
In-Reply-To: <20190612102248.18903-4-david@redhat.com>
References: <20190612102248.18903-1-david@redhat.com>
        <20190612102248.18903-4-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 12 Jun 2019 10:35:21 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 12 Jun 2019 12:22:47 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's use the error value that is typically used if HW support is not
> available when trying to load a module - this is also what systemd's
> systemd-modules-load.service expects.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/crypto/prng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
