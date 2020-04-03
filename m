Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81A6019DEE8
	for <lists+linux-s390@lfdr.de>; Fri,  3 Apr 2020 21:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgDCTzI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Apr 2020 15:55:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727627AbgDCTzH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Apr 2020 15:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585943706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HF0Zwc1wocMpHH80a9Ld76/ETXaQKsm1NeNpR7kpIqs=;
        b=Qoi89/YNwf9Uv93xogFkD70bO4TlGN7pFpB53xHTO5zGTYxM722KZ03pnK1sJPgu+5SHKD
        dEKMGlilJrNcLXBlBxsXMc7C2NSdXi/Eq9B8Goqo18PTUQOYSUDWjoqSS7bQobnupUkypG
        ASmziJ8JdwnorWiTMy5+U5xWLwbaUhM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-Bx3vFtkUPY6pJ9ripfuRqQ-1; Fri, 03 Apr 2020 15:55:04 -0400
X-MC-Unique: Bx3vFtkUPY6pJ9ripfuRqQ-1
Received: by mail-wm1-f69.google.com with SMTP id u6so2519149wmm.6
        for <linux-s390@vger.kernel.org>; Fri, 03 Apr 2020 12:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HF0Zwc1wocMpHH80a9Ld76/ETXaQKsm1NeNpR7kpIqs=;
        b=rmeMd7dYNjqFEYWphhRDgLP5LxIgHFeLFLl0GG3UvQBGSFd9h9HIIMzXFkNCzd2UGp
         l6wwdHbRnExKU5gpm6fnph2fPuHKjwxmpaGo0Hp7g8AmTl+ROPla5yK8JNa6CmUDS1eQ
         EafovdlO2vlPCA1nIdgvBqi/+INWXF0PLamYQDzEnXt6OnZuR5IsuVFIHSFs7yUPm4Sc
         PH5iwI6XDvUKeaaDkUGI2gNiP1/TcyNRvWdCV/k7nYsu9BwcV7mT72PUzel01jZgd4Gj
         G9EaMKcW7znCpEQl3XbA5Y2JjMH5vwN44Az/4DOlD0I7DiX3JcyA1fxzx/3Rz+Eac1kv
         8FRw==
X-Gm-Message-State: AGi0PuZDvZGIJaTlNZwFcSHjXOjt+Gkz8SAWQFIgf3OK33a3THfxp+xg
        fyoMFW9eNYG4jO6OGzAtARt4Lwd9hprXA4Jf/hiFLDWZ6CrRAsKKbdx0FYW5RajJTRd1K2NN5d6
        YdWZq3/7DBvvXaiyFM+gVgA==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr11032868wrx.148.1585943703357;
        Fri, 03 Apr 2020 12:55:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypIMlN52jfL13U65g+yzderJRf7TKcAdljqBnIneSxRjajZqcZuVG4ls3JkT8t9gOas3TmozzA==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr11032855wrx.148.1585943703163;
        Fri, 03 Apr 2020 12:55:03 -0700 (PDT)
Received: from [192.168.3.122] (p5B0C69E0.dip0.t-ipconnect.de. [91.12.105.224])
        by smtp.gmail.com with ESMTPSA id y1sm5470162wmd.14.2020.04.03.12.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 12:55:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/5] KVM: s390: vsie: Fix region 1 ASCE sanity shadow address checks
Date:   Fri, 3 Apr 2020 21:55:02 +0200
Message-Id: <67F45F4F-33CB-455A-8CB8-7D20D9A2BF2F@redhat.com>
References: <59b411eb-dabe-8cac-9270-7a9f0faa63d5@de.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>, stable@vger.kernel.org
In-Reply-To: <59b411eb-dabe-8cac-9270-7a9f0faa63d5@de.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



> Am 03.04.2020 um 19:56 schrieb Christian Borntraeger <borntraeger@de.ibm.c=
om>:
>=20
> =EF=BB=BF
>=20
>> On 03.04.20 17:30, David Hildenbrand wrote:
>> In case we have a region 1 ASCE, our shadow/g3 address can have any value=
.
>> Unfortunately, (-1UL << 64) is undefined and triggers sometimes,
>> rejecting valid shadow addresses when trying to walk our shadow table
>> hierarchy.
>=20
> I thin the range of the addresses do not matter.
> Took me a while to understand maybe rephrase that:
>=20
> In case we have a region 1 the following calculation=20
> (31 + ((gmap->asce & _ASCE_TYPE_MASK) >> 2)*11)
> results in 64. As shifts beyond the size are undefined the compiler is fre=
e to use
> instructions like sllg. sllg will only use 6 bits of the shift value (here=
 64)
> resulting in no shift at all. That means that ALL addresses will be reject=
ed.

Interestingly, it would not fail when shadowing the r2t, but only when tryin=
g to shadow the r3t.

>=20
> With that this makes sense.=20
>=20
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>=20

In case there are no other comments, can you fixup when applying, or do you w=
ant me to resend?

Cheers=

