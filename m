Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931B4234415
	for <lists+linux-s390@lfdr.de>; Fri, 31 Jul 2020 12:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbgGaKbR (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 31 Jul 2020 06:31:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732280AbgGaKbR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Jul 2020 06:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596191475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJSBXUFrdCM5TndrvSRo8Fs138MbvjvWCbgK7xvxags=;
        b=azVpBTrUMz64UnhNhUbEUJUcpRNfngG6AL7lyJpGHZXUGW+4R1p4vFMTGcWs02DZps06+n
        Q7T6PnmiJcmKZZR1g2kL5TeE5/YHlJTYoUxthL58kJZO6ptwZ+K7gN8w4fV7Do2e+naJBc
        pc72J8qPTRoJs2scgqqvQSQLXZ0YNRE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-DkOcpkApNQaZ7_dHtH618g-1; Fri, 31 Jul 2020 06:31:13 -0400
X-MC-Unique: DkOcpkApNQaZ7_dHtH618g-1
Received: by mail-wm1-f69.google.com with SMTP id u68so2004943wmu.3
        for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2020 03:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CJSBXUFrdCM5TndrvSRo8Fs138MbvjvWCbgK7xvxags=;
        b=WaJlSpZDv/Y2ks6ffmu71ZFxm2VNdHw6ENzNS3u3QTCYiX9rqanl62XCxBfLCNv4ZZ
         yduFvIElFTL+tQMnk9Tf260RKODFqqzWP34nRro2AAAfodupw2iorj48NnnUN55dD9e2
         U773EZrZzcijDY/d/sD+hleQVDZMnqIi+6R4QQIePHl0+/596eIaaE65oc9ogLetF6sO
         HCd7lOhWlPrNPs/2a/ngUmFoa7RtOIYm45cuYvRZZj5ySUegu21FoXMGTDq5Cl25EvCf
         3B6zutlzwfD4yO0mpwpMcbJANFY0L+WfvZ4AWmodv+MO+csj6xX2ADp8iZCRnj/ULk/0
         jjIw==
X-Gm-Message-State: AOAM530+nfEPnQUby7kPn04dLUDxdQVJGUYo0kiBVhRAo7dUOXuAO0wf
        pRb/uYYWXFsXlCuJ2SSJonwQ2GbYqxAWkaA0YVVOlkUsebv9punjKH8lh3/H9ljlyv7THQL5cKl
        T6225tB6vZ1O1Yeu3OCRmww==
X-Received: by 2002:a05:600c:2157:: with SMTP id v23mr3184595wml.38.1596191471834;
        Fri, 31 Jul 2020 03:31:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAk54fcZLnkutyZ4lX9DRT11vUuBTupcPXiC6WHDu3DDohZJqB74vqGolh54pFZwDp0t0cMw==
X-Received: by 2002:a05:600c:2157:: with SMTP id v23mr3184576wml.38.1596191471641;
        Fri, 31 Jul 2020 03:31:11 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id p8sm14046645wrq.9.2020.07.31.03.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 03:31:11 -0700 (PDT)
Subject: Re: [kvm-unit-tests GIT PULL 00/11] s390x patches
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com,
        thuth@redhat.com, pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com
References: <20200731094607.15204-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dfce14f4-5e7b-9060-6520-06e7dd69cfa4@redhat.com>
Date:   Fri, 31 Jul 2020 12:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200731094607.15204-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 31/07/20 11:45, Janosch Frank wrote:
>   https://github.com/frankjaa/kvm-unit-tests.git tags/s390x-2020-31-07

Pulled, thanks.  FWIW you may want to gitlab in order to get the CI.

Paolo

