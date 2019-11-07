Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0BF3056
	for <lists+linux-s390@lfdr.de>; Thu,  7 Nov 2019 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfKGNqQ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 7 Nov 2019 08:46:16 -0500
Received: from mout.web.de ([212.227.17.12]:37367 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731058AbfKGNqQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 Nov 2019 08:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573134362;
        bh=RHwsmZfu4iRzxYZNEyr0qQy3SUcUgNwBxdLZdcmUjgc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=puTI2JbdiOsRmIMIiinGR5mqOPHqBtjvUYQGcGIUTz8eQujnVksMCSOc6iavYpfcW
         c+RymsEqOr1K+HKCCoJkWyjBBk1lY/eH2j1uH7FKLoOu++pLEAoQuA197XT+S5s8YS
         jNJhxVxG3qtwxwl0Rv24hcCZT+Ma3YUyKXXSWWug=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.68.124]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5wrF-1hj1RD2UA5-00xvBX; Thu, 07
 Nov 2019 14:46:02 +0100
Subject: Re: [PATCH v2] s390/pkey: Use memdup_user() rather than duplicating
 its implementation
To:     =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Joe Perches <joe@perches.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <deb7893f-3cfe-18fc-3feb-b26b290bf3c6@web.de>
 <833d7d5e-6ede-6bdd-a2cc-2da7f0b03908@de.ibm.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1b65bc81-f47a-eefa-f1f4-d5af6a1809c0@web.de>
Date:   Thu, 7 Nov 2019 14:45:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <833d7d5e-6ede-6bdd-a2cc-2da7f0b03908@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ih/E6MytGxAanl6pgyvwl9rZHT10wv4oanaEBNdSe8jsW/2Sbv/
 ilid4DM8rLEjURQV/AZIIVgsxXxGrStpGW/Q47GHMmtK5OJPbXESpWSoA6SMBrzycPx1VSS
 Y7zsc3u4pfudlSU2p2ODfvxR2tkjM8AJkiNGkYd1brGlm/70D6RagbaxHhtyYgeJro0aLES
 /FzfE8ca3bk7oa4t5TeDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uLwzaTJ+JGI=:ydqvPCFhWfiRClaXqe47uq
 d/+dMes6X8dGWCysBu+/fkviNvTX9UQcxVVhF942Jnjd1nX5IFKiuoIlFiFaOIOhubRexTlhl
 s5IphzPym8ivRBtlQ4X0yXmk5l2woFXMzq1py0vQ3kvK8LS3X8VDaRe5J+xejI+g+AhoFHyOR
 jWGf7kW5ZlcaWqjsuI8ux2fccVePmFKec4OTkRay4YQb3MUnWoa0+kHhzDW+h6gbvbPJPVlFo
 TVbCzpTtzadu1jlfjJ7I7/gmtcR5qFdgYDX7BVhq7c8yOdBQ05/lz/J7LGuTYa/SKC46SHAkD
 QPsQzsF8qRvPDAQ0OOedzDZulScAkKOJdf5K97AX9j5fLjinMN9ASxGvY1M7lcHHB95V3bKtn
 qIrDNFnK9pJnm5GHBx1IcWHxq06E6p9Vu3cBsBMPhq2sChZJUmKJh7uSQ0GC225FvYBh36TAU
 F7fPkeifaQ/IjGNf7dostRAyD49rYuL+uibUYvdpIgi6dwpaZS4VZqhX8uRdKYQTMR7oTiTEK
 LcOSJDvOHldNwrq2Fb+GDdJHNjQUFf/yDzyfXqOcJO25B4pPXL28xC+Ez5mcYWhTnMi2so0Ab
 OxwOkHXa9vMxYoe/+Gddmlv5Hcygoy3C608VMnCa31xUbwn4tC12t4uO01CVlARsZ1EkxofJ6
 qTY9XODFpvZDR6JxBOUcmGHOtwlfMpSHSF884IF2b11+i0h51cARsSz0ANSkn9DTnLqEuFlJA
 A/GPiEne20allxi8ocG3yS3LECCQo/GeQk0YgtIPtycDILUY6uH7WC7YD2CtSW0Nk3yHjAkWz
 UuesqQoje4MZwQsTxsLX63hYRKZD4b/rqIW7TGZGqAnZDyonmzgWJJjIel67hEBDIbsSz7y2v
 gtL6WMePmn38MB3hkzZDLquHhdHfkV8gJ2RjbMcTOiBxfuTlX0RBF52iwaJda/52g1WqcU+nG
 5CUjl3n9Zxrlt/QNG98mOC93IkttgJ8+A7rH7Xg1E/DgqJq4r2NBcCy11a7/d0f1ZVhA3Fo3c
 mxAtLFw5qDiThuCca8pDPPhGy/h3cv7rI4uXBLab0KQcCu9vB10s4pT6kk8FksZIQJCLwltfj
 k2RvosviwDODttz7okBfVxDsH/QVAI8ROaEZJUWPHkiymleuuXy+3vaDw1tnUZnIDUJJqdQj1
 8AJDBO2PT3nZZ7Ox8XHaGhuRA+DGy7fiDVOa90hstOIqn3tTwuyp2nu9C1U1eUfMprvPQnPKX
 ZBw3Ldby0SxXeU6kNIiZpO0wHdDG5QglnfsMH/BxgPesRlJOXvsRYFZtM7D8=
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>> Reuse existing functionality from memdup_user() instead of keeping
>> duplicate source code.
>>
>> Generated by: scripts/coccinelle/api/memdup_user.cocci
>>
>> Delete local variables which became unnecessary with this refactoring
>> in two function implementations.
>>
>> Fixes: f2bbc96e7cfad3891b7bf9bd3e566b9b7ab4553d ("s390/pkey: add CCA AE=
S cipher key support")
>
> With that patch description, the Fixes tag is wrong...but (see below)

I wonder about such a conclusion together with your subsequent feedback.


>>  static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqn=
s)
>>  {
>
> This part below is not an equivalent replacement.

The shown refactoring provides also different run time characteristics,
doesn't it?


> In fact you are fixing a bug here...

Thanks for your acknowledgement.


>> -	void *kapqns =3D NULL;
>> -	size_t nbytes;
>> -
>> -	if (uapqns && nr_apqns > 0) {
>> -		nbytes =3D nr_apqns * sizeof(struct pkey_apqn);
>> -		kapqns =3D kmalloc(nbytes, GFP_KERNEL);
>> -		if (!kapqns)
>> -			return ERR_PTR(-ENOMEM);
>> -		if (copy_from_user(kapqns, uapqns, nbytes))
>
> 	.... here we would need to kfree kapqns, but we do not. So this is
> a memory leak. Isnt it?

This is another undesirable software weakness because of incomplete
exception handling in the previous copy approach.


> So indeed this is fixing something. But please rework your the patch
> description accordingly.

Can the final committer pick the opportunity up to extend the change
description another bit?


>> +	if (!uapqns || nr_apqns <=3D 0)
>> +		return NULL;
>>
>> -	return kapqns;
>> +	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
>>  }


Would you like to add any tags for the presented software improvement?

Regards,
Markus
