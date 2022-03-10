Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48BB4D51D1
	for <lists+linux-s390@lfdr.de>; Thu, 10 Mar 2022 20:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbiCJSjm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Mar 2022 13:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiCJSjl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Mar 2022 13:39:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2977018CC20
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 10:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646937519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4IYeQmfhXlzTaLdPSgWyci5vP6ISAQPbyhuQUoHxht8=;
        b=dtcjy6LG+SB6OQGB/jCzApBGGQYCftQAn0ISF0qZZ+SdMKInD5hUcGiMTYmLKo52z2O/st
        YnvsDMQQjrKdVylu2Z/rOfAZnaFxRyHMms/IWZOmLyuHr2FBLQFXgKvzJNG/FGqe2ua/8n
        bKV857r7kaXJuCBG7xaILIjeldyecGY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-3vFs7SUsMUSiqysosVoePg-1; Thu, 10 Mar 2022 13:38:38 -0500
X-MC-Unique: 3vFs7SUsMUSiqysosVoePg-1
Received: by mail-wm1-f69.google.com with SMTP id x5-20020a1c7c05000000b00389bcc8df46so2642210wmc.0
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 10:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=4IYeQmfhXlzTaLdPSgWyci5vP6ISAQPbyhuQUoHxht8=;
        b=JKwIv6UxzEudit4pMJq4QTtNkTStmOf34SeTrmUA79VreJRa5r0kC6Nr8p8Bdc3leC
         zvWSd4oqpChyAr/2+34lMd8dOq3mg+eOdEGkmL2iQkpmC9NCpfEK8Vi5cLezOUiVwlMq
         kCh7+nntNQnYFGj758bYTHDw5IKgGLNyncpRKA7lB93p9iXMo5FYtpfLGQPiKEQPoZ/x
         PbxWNyXg8LSdJBtCjSQ+fMbxYwF/mf2oCahPtXfz5CJWZQo9QhuKroi6UMrRurbKVjKg
         cIQCq/1PFyZ/7vuobQWsm7ucnlJQ4YriVqe8TmEoSol9jtC+rYp41Ja1Xk9fQKeNghNV
         l+1g==
X-Gm-Message-State: AOAM532tdzxuGyBZ3cIdcisJFzAbCMi85ceEFarFTdbD5AQgpnB/hDPT
        zMsJ4gMMG/bO6G/IGFwe6JlTo5vIYT+Q9JXVC7Kdb5a92+np6yqJdm45NhK35KNc5e/7uFGW21X
        bsBOAab0egGEZR3+mI4rVLQ==
X-Received: by 2002:a05:6000:1ac8:b0:1f1:f808:fb5b with SMTP id i8-20020a0560001ac800b001f1f808fb5bmr4551074wry.560.1646937515854;
        Thu, 10 Mar 2022 10:38:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXZyD+ehnyUpidu3fxX0sNDsEqUN5QklJrVAvPYsYfbLCPxQY05Xccfzw8I0/BKy59GOHe2Q==
X-Received: by 2002:a05:6000:1ac8:b0:1f1:f808:fb5b with SMTP id i8-20020a0560001ac800b001f1f808fb5bmr4551053wry.560.1646937515605;
        Thu, 10 Mar 2022 10:38:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:6100:d527:e3ca:6293:8440? (p200300cbc7086100d527e3ca62938440.dip0.t-ipconnect.de. [2003:cb:c708:6100:d527:e3ca:6293:8440])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4a4c000000b001e68ba61747sm4756329wrs.16.2022.03.10.10.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 10:38:35 -0800 (PST)
Message-ID: <efe7b6f5-4266-5a80-837a-7ee2253d3185@redhat.com>
Date:   Thu, 10 Mar 2022 19:38:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
 <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com>
 <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10.03.22 19:35, Linus Torvalds wrote:
> On Thu, Mar 10, 2022 at 9:13 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> For the time being, the idea LGTM.
> 
> I'll take that as an acked-by, and I think I'll just commit it to my
> real tree rather than delay this fix for the next merge window (only
> to have it then be marked as stable and applied that wat).

Yes, ACK and makes sense.


-- 
Thanks,

David / dhildenb

