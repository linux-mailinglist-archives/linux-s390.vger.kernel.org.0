Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E6CFD6C6
	for <lists+linux-s390@lfdr.de>; Fri, 15 Nov 2019 08:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfKOHMs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 15 Nov 2019 02:12:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27093 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726717AbfKOHMs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Nov 2019 02:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573801966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwBfqfSDk+3q6SadjRfZt3wD+qXcHprsMEK10QU8HyE=;
        b=VZGL8yoimZSpDlpIPqRb+UotxLay1mkwH9EMLYGdfu+XMliwpEdkV79TUV2YjKm6UhWohG
        kum2PQ9+Op6mxvc3U6L2QdYSr9eIeCKeNhgk2RWV0LfdmL2psi+6oQonACqEWtw++TBG82
        6OBrJtXNgvskYc/nNIsV24hV52tX7Ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-q79EV1FWMHqL8pZ6FfuqmA-1; Fri, 15 Nov 2019 02:12:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 490A3801FA1;
        Fri, 15 Nov 2019 07:12:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-84.ams2.redhat.com [10.36.116.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30F62600C1;
        Fri, 15 Nov 2019 07:12:40 +0000 (UTC)
Subject: Re: [PATCH v1 3/4] s390x:irq: make IRQ handler weak
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-4-git-send-email-pmorel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <5fc6450e-ec88-d500-7fc9-9e17e41f2dd0@redhat.com>
Date:   Fri, 15 Nov 2019 08:12:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1573647799-30584-4-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: q79EV1FWMHqL8pZ6FfuqmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 13/11/2019 13.23, Pierre Morel wrote:
> Having a weak function allows the tests programm to declare its own IRQ
> handler.
> This is helpfull when developping I/O tests.
> ---
>  lib/s390x/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 7aecfc5..0049194 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -140,7 +140,7 @@ void handle_mcck_int(sregs_t *regs)
>  =09=09     lc->mcck_old_psw.addr);
>  }
> =20
> -void handle_io_int(sregs_t *regs)
> +__attribute__((weak)) void handle_io_int(sregs_t *regs)
>  {
>  =09report_abort("Unexpected io interrupt: at %#lx",
>  =09=09     lc->io_old_psw.addr);
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>

