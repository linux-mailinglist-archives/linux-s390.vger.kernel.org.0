Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133F823AC3E
	for <lists+linux-s390@lfdr.de>; Mon,  3 Aug 2020 20:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHCSSz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 3 Aug 2020 14:18:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44946 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728466AbgHCSSz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Aug 2020 14:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596478734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPKDeMAAn3g8NgJRsWCV0tXrMbTpTCdEV09ubLsqzjc=;
        b=gtPmz+EovclmGIU+g500zerCWsMnyXTrhO4tDgx+oth3E0ZM0ezkAcfjZtN/RuqWp3KjVb
        IThkjd1fTy0hhkG/TyybveQsEBRyrNdRkvyXElneOgAqjdDgT/PxZvZeMmumdVIQ3nLJu7
        mDDVGUxxnl89XEvE9cyLA863B+wZmxU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-hZihhdNDMIS8DJlsh76VvQ-1; Mon, 03 Aug 2020 14:18:52 -0400
X-MC-Unique: hZihhdNDMIS8DJlsh76VvQ-1
Received: by mail-wm1-f69.google.com with SMTP id a207so99439wme.9
        for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2020 11:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yPKDeMAAn3g8NgJRsWCV0tXrMbTpTCdEV09ubLsqzjc=;
        b=LnTQ8h3AcLZoQdDZAIbh6p6KUmyT9EIl/oj7aNsbCVWxWmDRxhMAJZV29FiZemhGnt
         Zu2VAokyoLmpUJfdl8RxsQeD/ruGjdbppFcJ2bd2Pa6jUOrBIr3BxZG2x5NFv64kWCNQ
         5UYxTlAQUzP9KjNFxzcB0RnJcJp2iWFaiChhbSfdRqPkCcK3x/gxX9eqfAtn4qWRVH7B
         D5sd1VLhNkL8mvh17mUuI0AEn9iceaGECIRJ8aO4LJmSQWumU1cZVUv5ZnKkMW+dM2IU
         TxVxYN2gNczlkPtf603Iu9xc0yxXzkTdFjomLdd6Px7ZJbldOeVsf/0aa5NvBKNGFKfh
         22VQ==
X-Gm-Message-State: AOAM531273kefQZH83D4Ug1moDn4sZFVEg923HB/vzb+sq6x1Djj9kie
        eu0jJTeb0YG/XkgT9rtdwTggGNxULWGqUjYh8f/stxFW32nRyrpwa06dztJHJXc7eqrdSlQUd4P
        fU0Hc1CcKJzdOX8m8rdhNLg==
X-Received: by 2002:a1c:a3c4:: with SMTP id m187mr397244wme.43.1596478731219;
        Mon, 03 Aug 2020 11:18:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGD9HBEfhlRLyGlm/2kLSdE4Zk4T6dBgmZJE1M6Fy+nfUqrm4TvyTkpuhyCUN5QEnwNLqf6Q==
X-Received: by 2002:a1c:a3c4:: with SMTP id m187mr397234wme.43.1596478731015;
        Mon, 03 Aug 2020 11:18:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20? ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
        by smtp.gmail.com with ESMTPSA id y203sm694574wmc.29.2020.08.03.11.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 11:18:50 -0700 (PDT)
Subject: Re: [GIT PULL 0/2] KVM: s390: feature for 5.9
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20200730094857.175501-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfdecb8b-726c-63ae-8438-5f9c7338435f@redhat.com>
Date:   Mon, 3 Aug 2020 20:18:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200730094857.175501-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/07/20 11:48, Christian Borntraeger wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.9-1

Pulled, thanks.

Paolo

