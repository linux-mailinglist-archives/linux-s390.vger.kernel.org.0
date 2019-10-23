Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1247DE1483
	for <lists+linux-s390@lfdr.de>; Wed, 23 Oct 2019 10:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbfJWIlo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 23 Oct 2019 04:41:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28327 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732361AbfJWIln (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Oct 2019 04:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571820102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLh23yxTCSuHeLb+hzu3fpiiqPuj5Q3yo8PvgLNLhns=;
        b=SZcDIsOOlizkh/4aIC3M7gJHzaQVN8f8/DCK43aE9tNKaAz6wIdDJho1fOPPYCMsMYapSl
        /AGBDhg9cj2mDqUMMeAG4vVYgnVeCGGD9+T2EyhG7C5Bh01ZYm8dEYu7af8BHyHlBceNjh
        Gjsxmpv0H+63VePE4HZoqXaXJnETKtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317--M_DlnWDMqujXpM4-PsqAw-1; Wed, 23 Oct 2019 04:41:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DB3680183D;
        Wed, 23 Oct 2019 08:41:38 +0000 (UTC)
Received: from [10.36.117.79] (ovpn-117-79.ams2.redhat.com [10.36.117.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BD0D60BE1;
        Wed, 23 Oct 2019 08:41:37 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix selftest malloc check
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, thuth@redhat.com,
        borntraeger@de.ibm.com
References: <20191023084017.13142-1-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b5363884-7360-ffc4-b572-f1942cbfae20@redhat.com>
Date:   Wed, 23 Oct 2019 10:41:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023084017.13142-1-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -M_DlnWDMqujXpM4-PsqAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23.10.19 10:40, Janosch Frank wrote:
> Commit c09c54c ("lib: use an argument which doesn't require default
> argument promotion") broke the selftest. Let's fix it by converting
> the binary operations to bool.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/selftest.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/s390x/selftest.c b/s390x/selftest.c
> index f4acdc4..9cd6943 100644
> --- a/s390x/selftest.c
> +++ b/s390x/selftest.c
> @@ -49,9 +49,9 @@ static void test_malloc(void)
>   =09*tmp2 =3D 123456789;
>   =09mb();
>  =20
> -=09report("malloc: got vaddr", (uintptr_t)tmp & 0xf000000000000000ul);
> +=09report("malloc: got vaddr", !!((uintptr_t)tmp & 0xf000000000000000ul)=
);
>   =09report("malloc: access works", *tmp =3D=3D 123456789);
> -=09report("malloc: got 2nd vaddr", (uintptr_t)tmp2 & 0xf000000000000000u=
l);
> +=09report("malloc: got 2nd vaddr", !!((uintptr_t)tmp2 & 0xf0000000000000=
00ul));
>   =09report("malloc: access works", (*tmp2 =3D=3D 123456789));
>   =09report("malloc: addresses differ", tmp !=3D tmp2);
>  =20
>=20

See

https://lore.kernel.org/kvm/CAGG=3D3QUdVBg5JArMaBcRbBLrHqLLCpAcrtvgT4q1h0V7=
SHbbEQ@mail.gmail.com/T/


--=20

Thanks,

David / dhildenb

