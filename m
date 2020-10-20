Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226072875CC
	for <lists+linux-s390@lfdr.de>; Thu,  8 Oct 2020 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgJHONp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 8 Oct 2020 10:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729840AbgJHONp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 10:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602166423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoWvB7Y1ueutrTOCt1Bhbac+nUJcW/jM9KT4QwXcBcE=;
        b=YifpA98zIJTC5BtCRN/v7WnsR8JKCg5Lp4ecEImHrAFOChcEMI3l4qr4h3w++TCgxZbnKl
        wBd3lSHsCj6Uxs3DSEYoa7zilEiz9nNXiOrP4/DuO3H9FD/mpIWNO2Z8mntyuznrglhjE9
        zrxZ2zKlnWB/OZkrtUhnP9ONB/+aeRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-xy3rY8tTPwi2VkkJd7Posg-1; Thu, 08 Oct 2020 10:13:42 -0400
X-MC-Unique: xy3rY8tTPwi2VkkJd7Posg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8061D805729;
        Thu,  8 Oct 2020 14:13:40 +0000 (UTC)
Received: from gondolin (ovpn-113-82.ams2.redhat.com [10.36.113.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A970A5C1BD;
        Thu,  8 Oct 2020 14:13:38 +0000 (UTC)
Date:   Thu, 8 Oct 2020 16:13:36 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 04/10] s390/dasd: Remove unused parameter from
 dasd_generic_probe()
Message-ID: <20201008161336.4fd47919.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-5-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-5-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu,  8 Oct 2020 15:13:30 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> The discipline argument in dasd_generic_probe() isn't used and there is
> no history how it was used in the past. Remove it.
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd.c      | 3 +--
>  drivers/s390/block/dasd_eckd.c | 2 +-
>  drivers/s390/block/dasd_fba.c  | 2 +-
>  drivers/s390/block/dasd_int.h  | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

