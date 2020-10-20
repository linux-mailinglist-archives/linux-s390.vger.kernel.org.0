Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71140287660
	for <lists+linux-s390@lfdr.de>; Thu,  8 Oct 2020 16:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgJHOtT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 8 Oct 2020 10:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730538AbgJHOtT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 10:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602168558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtnjnOudKVNGnhTLiYK3W2k9TMhAQ4dYRpix3rCRVDI=;
        b=hvMiAGoyCh7XTWoe4ceNW4pxo9+yKDZ8/2H8yxHPFusfLqJovzNqsUocr0lQ5lIk/hFPUm
        jukAsvtGL6mROLJ0nQN6WOQqS1xvQnXxQ8a0PpdLEfS0QoQfh4w/siOW66Oix6AMwJlk4d
        HBDtb0BWEd1NKC1nBaelCNRQC/j9Sp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-uGgqk34NODCA3a9xTDmX2A-1; Thu, 08 Oct 2020 10:49:15 -0400
X-MC-Unique: uGgqk34NODCA3a9xTDmX2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80759106C104;
        Thu,  8 Oct 2020 14:49:00 +0000 (UTC)
Received: from gondolin (ovpn-113-82.ams2.redhat.com [10.36.113.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADF9A5C1BD;
        Thu,  8 Oct 2020 14:48:58 +0000 (UTC)
Date:   Thu, 8 Oct 2020 16:48:56 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 09/10] s390/dasd: Prepare for additional path event
 handling
Message-ID: <20201008164856.6b61f2ba.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-10-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-10-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu,  8 Oct 2020 15:13:35 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> As more path events need to be handled for ECKD the current path
> verification infrastructure can be reused. Rename all path verifcation
> code to fit the more broadly based task of path event handling and put
> the path verification in a new separate function.
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd.c      |  4 +-
>  drivers/s390/block/dasd_eckd.c | 78 +++++++++++++++++++---------------
>  drivers/s390/block/dasd_int.h  |  1 +
>  3 files changed, 47 insertions(+), 36 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

