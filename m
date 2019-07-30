Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6AF7B2E0
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jul 2019 21:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfG3TGH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 30 Jul 2019 15:06:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50610 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfG3TGG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Jul 2019 15:06:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so58236151wml.0
        for <linux-s390@vger.kernel.org>; Tue, 30 Jul 2019 12:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5S3d6uVPy5cHx0D/YtQpJ1Nv52peUkHqdhDqHrKpBs4=;
        b=cnTzImMAJicZuvHtalOHzA0WQavd+aLbhuVsjdY0muyYhoiBlFSrRS0wTXj5VrC5wi
         BMoF3QZVTnrEt+zePs1vnIS69UhSod4ItpckoCkRhgLcEfQ1m96rM4KwdPdop5uuKgJr
         Vj08VLw6+pZyf/oQlpGg7lU+hgbXWgmGQSiyBWkuN0gFP+FsthO14mDBO7xJ1LpePZ4y
         +Kof2bfJHcU7eRiz9ZdVDBDUi3Vc3BLACJQkUNsSj0SpA1eB+cLRqkZkjaYBdDRADy3l
         k4EDJN177TX3VjUwrpPGQiYmIpKYjjYXclwc/Y3wE/VDTy5n4VdVcsmFhd2PafBCkOIP
         f9Eg==
X-Gm-Message-State: APjAAAUdaDCPghvcuxP3lo1uVollDXPJJfrfniFdgxJLNN/NCEJeD681
        4dv64IxFL+wcG9O6ipTGX/VQ5A==
X-Google-Smtp-Source: APXvYqy9fQXMKLPUlGzphq5DKUH+Y/qap06CQVq/DDM7cuDdGIkt/L5KUAIw0QzQnc/ME20wcT8zfw==
X-Received: by 2002:a1c:dc46:: with SMTP id t67mr98676529wmg.159.1564513564597;
        Tue, 30 Jul 2019 12:06:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id f2sm62301670wrq.48.2019.07.30.12.06.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 12:06:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <d48ac43b-c960-54af-a145-360a67b4a3d9@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e9cd12ce-d4cf-95b7-15f8-84112527f6a7@redhat.com>
Date:   Tue, 30 Jul 2019 21:06:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d48ac43b-c960-54af-a145-360a67b4a3d9@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/07/19 16:57, Christian Borntraeger wrote:
> While this fixes the test (and the migration does work fine), it still
> means that s390x overindicates the dirty bit for sparsely populated
> 1M segments. It is just a performance issue, but maybe we should try 
> to get this fixed. Not sure what to do here to remember us about this, 
> adding this as expected fail?

if it's only on the first access after enabling dirty logging, that
shouldn't be that bad?

Paolo
