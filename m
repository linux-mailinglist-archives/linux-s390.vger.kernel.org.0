Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01952F1DD3
	for <lists+linux-s390@lfdr.de>; Wed,  6 Nov 2019 19:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKFSzJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 Nov 2019 13:55:09 -0500
Received: from mout.web.de ([212.227.17.12]:43155 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfKFSzJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 6 Nov 2019 13:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573066502;
        bh=yNR2i8yBHWbuPKdgETmn2ieMsq+ALmq+WPWZ9/wiV1c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eZkTw2MjsZdYC7Lx4hz6sW3DZNhn2qOzsIFyBhXj7i1ITIG0UAjapwK2Xo42kvNpb
         KIXxJJIl0NEmfLAz7KJcAvqwCusQVBzeqNoCdusBxqsBNqRa9uRqO18UFympjTooPP
         StCS6BBt4ZRV9Wfqi0FeEoO2EgeOaalUAsvN/ulI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.91.235]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MdLo7-1iA4G522gV-00IQqp; Wed, 06
 Nov 2019 19:55:02 +0100
Subject: Re: s390/pkey: Use memdup_user() rather than duplicating its
 implementation
To:     Joe Perches <joe@perches.com>, linux-s390@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <0f90b278-7b3e-6509-1633-301d16513c5d@web.de>
 <47c55ab899aafe10898e6581582363aa446b2091.camel@perches.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cba4068c-0d63-fc0a-44bb-2664b690f126@web.de>
Date:   Wed, 6 Nov 2019 19:55:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <47c55ab899aafe10898e6581582363aa446b2091.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:BjFNn5fqIyoVjEG+NH7voclOi4kz6Pj6vKE+XVVg/TN9u2QCR+g
 QW0xuV6dTodkZvp2oKDpKYoU4YtRPLXuqQFDk3wyNjqETk63FFlfSofwbUjAy/CLDFqF50f
 UlLTSTyUnZ63ddwwc3CvJnzjNR+NMZuB7NROEB0riPvzVVKa9A6vnEYSXYAghnxVS5a34N7
 u5xIf2zBmvPEWkwA+4b6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xFgSMHn3x/U=:SWKE0t1hVHozTAw7gKZF68
 jzQ0emQku1B4HJx+cFlap6C07b+1aG/OjmCdQ91k4VqLOtNsTMIq3TjOj6O1O2EEq7oXCSRXH
 324Sw5KKMsSZAXLyzkXewlKJrmthofX7cSGAX5j9MgFnIQ36kPa/m9Jpl6khCsNv6N++KLPdU
 /WntRWYF3332N+LFDuGVZJ+0F3m3XjnGWnlMoQ8wpwqCeL0QM9ITenNb/pQ/CiXIS+HguLRTi
 igKZWdKCuRkCPo4BecWC3S5TLnuLnulaDkYlmAfu4XJ/lHBqU+2wHyXEKRz74kZHBO+tYfc6s
 VUjcDtX0R+e8T4doqRilD6cINJoLtZWFcRbexcBU7a6e8piUnGK/RrN4TZlw+n5a1ODAT/8/T
 SrYpjaIgg5uHHMIsfSbvbwDif2HZc9kWxiZYBnXM1POZD5cUSjHljkGB6hhxxcwn9wmyM7Y7V
 intRD/wP7q2HCDiHXS1lPrYwAfQZoae0lBRBod8vdp2XhLyQtGcbQw3TbJ1X+LFs0BQCQs740
 puNzo16dP8NEso9drbCYNAPnZRc0+5D/v1VgWUmnaxz/Rb+4qC02fCsJX3MOQq2ZogOuPq6IP
 /4UQBEbhO1PFOsdH8aNJejfjMFhpvYETTpFSoWZZ4VLCImiC3stKzKyO0Ae8FoYHj1jGaXgft
 j45t++ulZEM4Y6+118oolQaYneEH8kjGYfC1PwVW7Yehz1q8e9ibh65wN8ktsqptmThb2ioCU
 MZJKLIEn7hWj51WE+0xXN6x4GxnmGXOGMwWCjBvlnEsRIJECw6ZkWb7NvrgL4idm01EcXsmld
 aAVLMKxLx19Ng710O1LPI16/r9XqhqdfM7Y4B/pE07zBOJGLoCLjKgZ7vkLASr783v5hru1JR
 AoJ6JiXndbJICVAl5NlGHscd5/KChZWsiQSFm/j2Ei+fnNJel2el02kisKqql1JRiXgPTwop5
 hdAJuIxVmZVCkAOtTTrqChA1Hzlqvpl1EHdqElun6aUONMsgnWbi4lK4ghBWcO2vq8G80L4lI
 ePtqMqjrABPb38+a3c3TYwzXV7N3ocaOLrPlAgj8K3rGxsLYMZqg4PRe44kCLxZ8fmVGvd2pG
 l13crS4X6xI8HbnoqSXxnhwdPWEJcOb3gngwpSk30Supn+fg48qfrwbrhixwLkDa51WCKhY+c
 yjKKuN7qe8X044uXoxXnnxw6pojJ7dMBxWzcWXN45ye2T6Y4ZRnRaIXyxF/ssVAddtIFCTFg3
 cQfM4pUPB3gH2CIuw6pdWQxp/uvI8i0Vy8s+LJqH8Qz2Vf17aLyEknZWA0qQ=
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> There is no bug here.

Do you find duplicated source code questionable?

Is this also an error item?

Regards,
Markus
